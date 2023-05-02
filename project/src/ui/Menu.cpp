#include <ui/Menu.h>

#ifdef HX_WINDOWS
#include <Windows.h>
#endif
#include <stdio.h>


namespace lime {


	Menu::Menu () {

		menuItemsLength = 0;
		menuItems = 0;

		parentMenu = 0;

		#ifdef HX_WINDOWS
		HMENU hMenu = CreateMenu();
		nativeMenu = hMenu;
		nativeWindow = 0;
		#endif

	}


	Menu::~Menu () {

		#ifdef HX_WINDOWS

		HMENU hMenu = (HMENU) nativeMenu;

		if (hMenu) {

			DestroyMenu(hMenu);
			hMenu = 0;

		}

		#endif

		nativeMenu = 0;

	}

	MenuItem** Menu::GetItems(int &numItems) {

		numItems = menuItemsLength;
		return menuItems;

	}


	void Menu::SetItems (MenuItem* items[], int numItems) {

		for (int i = 0; i < menuItemsLength; i++) {

			MenuItem* menuItem = menuItems[i];
			Menu* submenu = menuItem->submenu;

			if (submenu) {

				submenu->parentMenu = 0;

			}

		}

		menuItems = items;
		menuItemsLength = numItems;
		RefreshItems();

	}


	void Menu::RefreshItems () {

		#ifdef HX_WINDOWS

		HMENU hMenu = (HMENU) nativeMenu;

		if (hMenu) {

			int oldMenuItemsLength = GetMenuItemCount(hMenu);
			for(int i = 0; i < oldMenuItemsLength; i++)
			{
				RemoveMenu(hMenu, 0, MF_BYPOSITION);
			}

			for(int i = 0; i < menuItemsLength; i++) {

				MenuItem* menuItem = menuItems[i];

				if (menuItem->separator)
				{
					AppendMenuA(hMenu, MF_SEPARATOR, 0, NULL);
				}
				else
				{
					int uFlags = 0;
					uFlags |= MF_STRING;

					if (menuItem->checked)
					{
						uFlags |= MF_CHECKED;
					}

					Menu* submenu = menuItem->submenu;
					if (submenu)
					{
						submenu->parentMenu = this;
						uFlags |= MF_POPUP;
						HMENU hSubmenu = submenu->nativeMenu;
						AppendMenuA(hMenu, uFlags, (UINT_PTR) hSubmenu, menuItem->text);
					}
					else
					{
						AppendMenuA(hMenu, uFlags, menuItem->id, menuItem->text);
					}

				}
			}

			if (nativeWindow) {

				DrawMenuBar(nativeWindow);

			} else if (parentMenu) {

				parentMenu->RefreshItems();

			}

		}

		#else

		printf("Menu::RefreshItems not implemented\n");

		#endif

	}


	Menu* Menu::CreateAppMenu () {

		return 0;

	}

	void Menu::SetAsAppMenu () {

		// do nothing. app menu doesn't exist.

	}
}