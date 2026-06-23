package lime._internal.backend.flash;

import lime.graphics.Image;
import lime.ui.TrayIconAttributes;
import lime.ui.TrayEntry;
import lime.ui.TrayIcon;
import lime.ui.TrayMenu;

@:access(lime.ui.TrayIcon)
class FlashTrayIcon
{
	private var parent:TrayIcon;

	public function new(parent:TrayIcon)
	{
		this.parent = parent;
	}

	public function setIcon(image:Image):Void {}

	public function setTooltip(tooltip:String):Void {}

	public function remove():Void {}

	public function createMenu():TrayMenu
	{
		return null;
	}
}