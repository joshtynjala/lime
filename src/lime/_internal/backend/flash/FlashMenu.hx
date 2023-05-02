package lime._internal.backend.flash;

import lime.ui.Menu;
import lime.ui.MenuItem;

class FlashMenu
{
	private var parent:Menu;

	public function new(parent:Menu, menu:Dynamic)
	{
		this.parent = parent;
	}

	public function setItems(items:Array<MenuItem>):Void {}
}