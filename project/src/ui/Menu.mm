#include <ui/Menu.h>
#include <ui/MenuItem.h>
#include <ui/MenuItemEvent.h>

#import <Cocoa/Cocoa.h>

@interface NSMenuItemTarget: NSObject
{

    lime::MenuItem* targetMenuItem;
    lime::Menu* targetMenu;

}
-(id)initWithMenuItem:(lime::MenuItem*)menuItem menu:(lime::Menu*)menu;
-(IBAction)action:(id)sender;
@end
@implementation NSMenuItemTarget
-(id)initWithMenuItem:(lime::MenuItem*)menuItem menu:(lime::Menu*)menu
{

    self = [super init];
    targetMenuItem = menuItem;
	targetMenu = menu;
    return self;

}
-(IBAction)action:(id)sender;
{

	lime::MenuItemEvent event;
	event.type = lime::MENU_ITEM_SELECT;
	event.menuItemID = targetMenuItem->id;
	lime::MenuItemEvent::Dispatch(&event);

}
@end


namespace lime {

	Menu::Menu () {

		menuItemsLength = 0;
		menuItems = 0;

		parentMenu = 0;

		NSMenu* nsMenu = [[NSMenu alloc] init];
		nativeMenu = nsMenu;

	}

	Menu::Menu (void* fromNativeMenu) {

		nativeMenu = fromNativeMenu;
		PopulateNativeItems();
	}


	Menu::~Menu () {

		NSMenu* nsMenu = (NSMenu*) nativeMenu;

		if (nsMenu) {

			NSMenu* nsSupermenu = [nsMenu supermenu];

			// if it has a supermenu, releasing the supermenu will automatically
			// release this one. double release will cause a crash!
			if (!nsSupermenu) {

				[nsMenu release];

			}
		}

		nativeMenu = 0;

	}

	MenuItem** Menu::GetItems(int &numItems) {

		numItems = menuItemsLength;
		return menuItems;

	}


	void Menu::SetItems (MenuItem** items, int numItems) {

		menuItems = items;
		menuItemsLength = numItems;
		RefreshItems();

	}


	void Menu::RefreshItems () {

		NSMenu* nsMenu = (NSMenu*) nativeMenu;

		if (nsMenu) {

			[nsMenu removeAllItems];

			for(int i = 0; i < menuItemsLength; i++) {

				MenuItem* menuItem = menuItems[i];

				NSMenuItem* nsMenuItem = nil;

				if (menuItem->separator) {

					nsMenuItem = [NSMenuItem separatorItem];

				}
				else {

					const char * text = menuItem->text;
					NSString* nsMenuItemText = text ? [NSString stringWithUTF8String:text] : @"";
					nsMenuItem = [[NSMenuItem alloc] initWithTitle:nsMenuItemText action:@selector(action:) keyEquivalent:@""];

					NSControlStateValue newState = menuItem->checked ? NSControlStateValueOn : NSControlStateValueOff;
					[nsMenuItem setState:newState];

					Menu* submenu = menuItem->submenu;

					if (submenu) {

						NSMenu* nsSubmenu = (NSMenu*) menuItem->submenu->nativeMenu;
						// make sure that the submenu's title matches the item's title
						// or it might not be displayed!
						[nsSubmenu setTitle:[nsMenuItem title]];
						[nsMenuItem setSubmenu:nsSubmenu];

					}

					NSMenuItemTarget* target = [[NSMenuItemTarget alloc] initWithMenuItem: menuItem menu: this];
					[nsMenuItem setTarget: target];
				}

				[nsMenu addItem:nsMenuItem];
			}

		}

	}

	Menu* Menu::CreateAppMenu () {

		NSMenu * appMenu = [NSApp mainMenu];

		return new Menu(appMenu);

	}

	void Menu::SetAsAppMenu () {

		NSMenu* nsMenu = (NSMenu*) nativeMenu;
		[NSApp setMainMenu:nsMenu];
	}


	void Menu::PopulateNativeItems() {

		NSMenu* nsMenu = (NSMenu*) nativeMenu;

		menuItemsLength = [nsMenu numberOfItems];
		menuItems = new MenuItem*[menuItemsLength];

		for (int i = 0; i < menuItemsLength; i++) {

			NSMenuItem* nsMenuItem = [nsMenu itemAtIndex:i];

			bool separator = [nsMenuItem isSeparatorItem];
			const char* text = [[nsMenuItem title] UTF8String];
			bool checked = [nsMenuItem state] == NSControlStateValueOn;

			MenuItem* menuItem = new MenuItem(separator);
			menuItem->text = text;
			menuItem->checked = checked;

			NSMenu* nsSubmenu = [nsMenuItem submenu];
			if (nsSubmenu) {

				Menu* submenu = new Menu(nsSubmenu);
				menuItem->submenu = submenu;

			}

			menuItems[i] = menuItem;

		}

	}
}