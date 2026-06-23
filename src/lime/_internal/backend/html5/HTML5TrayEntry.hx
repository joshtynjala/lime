package lime._internal.backend.html5;

import lime.ui.TrayEntryType;
import lime.ui.TrayMenu;
import lime.ui.TrayEntry;

@:access(lime.ui.TrayEntry)
class HTML5TrayEntry
{
	private var parent:TrayEntry;

	public function new(parent:TrayEntry, index:Int)
	{
		this.parent = parent;
	}

	public function remove():Void {}

	public function setLabel(label:String):Void {}

	public function setEnabled(enabled:Bool):Void {}

	public function setChecked(enabled:Bool):Void {}

	public function createSubMenu():TrayMenu
	{
		return null;
	}
}
