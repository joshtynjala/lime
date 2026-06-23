package lime._internal.backend.html5;

import lime.ui.TrayEntryType;
import lime.ui.TrayMenu;
import lime.ui.TrayEntry;

@:access(lime.ui.TrayMenu)
@:access(lime.ui.TrayEntry)
class HTML5TrayMenu
{
	private var parent:TrayMenu;

	public function new(parent:TrayMenu)
	{
		this.parent = parent;
	}

	public function insertTrayEntryAt(label:String, type:TrayEntryType, index:Int):TrayEntry
	{
		return null;
	}
}
