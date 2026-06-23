package lime._internal.backend.html5;

import lime.ui.TrayMenu;
import lime.graphics.Image;
import lime.ui.TrayIconAttributes;
import lime.ui.TrayIcon;

@:access(lime.ui.TrayIcon)
class HTML5TrayIcon
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