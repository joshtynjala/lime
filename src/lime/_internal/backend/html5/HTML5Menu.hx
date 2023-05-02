package lime._internal.backend.html5;

import lime.ui.Menu;
import lime.ui.MenuItem;

class HTML5Menu
{
	private var parent:Menu;

	public function new(parent:Menu, menu:Dynamic)
	{
		this.parent = parent;
	}

	public function setItems(items:Array<MenuItem>):Void {}
}