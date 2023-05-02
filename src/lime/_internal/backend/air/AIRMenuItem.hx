package lime._internal.backend.air;

import flash.display.NativeMenuItem;
import flash.events.Event;
import lime.ui.Menu;
import lime.ui.MenuItem;

@:access(lime.ui.Menu)
@:access(lime.ui.MenuItem)
@:access(lime._internal.backend.air.AIRMenu)
class AIRMenuItem
{
	private var nativeMenuItem:NativeMenuItem;
	private var parent:MenuItem;

	public function new(parent:MenuItem, nativeMenuItem:NativeMenuItem)
	{
		this.parent = parent;
		if (nativeMenuItem == null)
		{
			nativeMenuItem = new NativeMenuItem("", parent.__separator);
		}
		else
		{
			parent.__text = nativeMenuItem.label;
			parent.__checked = nativeMenuItem.checked;
		}
		this.nativeMenuItem = nativeMenuItem;
		nativeMenuItem.addEventListener(Event.SELECT, onMenuItemSelect);
	}

	public function setText(text:String):String
	{
		if (nativeMenuItem != null)
		{
			nativeMenuItem.label = text;
		}
		return text;
	}

	public function setChecked(checked:Bool):Bool
	{
		if (nativeMenuItem != null)
		{
			nativeMenuItem.checked = checked;
		}
		return checked;
	}

	public function setSubmenu(menu:Menu):Menu
	{
		if (nativeMenuItem != null)
		{
			nativeMenuItem.submenu = menu.__backend.nativeMenu;
		}
		return menu;
	}

	private function onMenuItemSelect(event:Event):Void {
		parent.onSelect.dispatch();
	}
}