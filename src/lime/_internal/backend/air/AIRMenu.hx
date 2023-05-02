package lime._internal.backend.air;

import flash.display.NativeMenu;
import flash.display.NativeMenuItem;
import flash.events.Event;
import lime.ui.Menu;
import lime.ui.MenuItem;

@:access(lime.ui.Menu)
@:access(lime.ui.MenuItem)
@:access(lime._internal.backend.air.AIRMenuItem)
class AIRMenu
{
	private var nativeMenu:NativeMenu;
	private var parent:Menu;
	private var __isDefault:Bool = false;

	public function new(parent:Menu, nativeMenu:NativeMenu)
	{
		this.parent = parent;
		if (nativeMenu == null)
		{
			nativeMenu = new NativeMenu();
		}
		else
		{
			__isDefault = true;
		}
		this.nativeMenu = nativeMenu;
	}

	public function refreshMenuItems(items:Array<MenuItem>):Array<MenuItem>
	{
		if (!__isDefault)
		{
			return items;
		}
		var refreshedItems:Array<MenuItem> = [];
		for(nativeItem in nativeMenu.items)
		{
			var found = false;
			for (item in items)
			{
				if (item.__backend.nativeMenuItem == nativeItem)
				{
					var submenu = item.submenu;
					if (submenu != null)
					{
						submenu.__items = submenu.__backend.refreshMenuItems(submenu.__items);
					}
					refreshedItems.push(item);
					found = true;
					break;
				}
			}
			if (found)
			{
				continue;
			}
			var item = createMenuItemFromNativeMenuItem(nativeItem);
			refreshedItems.push(item);
		}
		return refreshedItems;
	}

	public function setItems(items:Array<MenuItem>):Void
	{
		if (nativeMenu != null)
		{
			var nativeMenuItems = items.map(function(item:MenuItem):NativeMenuItem
			{
				return item.__backend.nativeMenuItem;
			});
			nativeMenu.items = nativeMenuItems;
		}
	}

	private function createMenuItemFromNativeMenuItem(nativeItem:NativeMenuItem):MenuItem
	{
		MenuItem.__pendingBackendHandle = nativeItem;
		var item = new MenuItem(nativeItem.isSeparator);
		if (nativeItem.submenu != null)
		{
			Menu.__pendingBackendHandle = nativeItem.submenu;
			item.__submenu = new Menu();
		}
		return item;
	}
}