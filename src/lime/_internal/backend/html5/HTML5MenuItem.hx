package lime._internal.backend.html5;

import lime.ui.Menu;
import lime.ui.MenuItem;

class HTML5MenuItem
{
	private var parent:MenuItem;

	public function new(parent:MenuItem, menuItem:Dynamic)
	{
		this.parent = parent;
	}

	public function setText(text:String):String {
		return text;
	}

	public function setChecked(checked:Bool):Bool {
		return checked;
	}

	public function setSubmenu(menu:Menu):Menu {
		return menu;
	}
}