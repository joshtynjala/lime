package lime._internal.backend.air;

import flash.desktop.NativeApplication;
import flash.desktop.SystemTrayIcon;
import flash.display.BitmapData;
import lime.graphics.Image;
import lime.ui.TrayEntry;
import lime.ui.TrayIconAttributes;
import lime.ui.TrayIcon;
import lime.ui.TrayMenu;
import lime._internal.backend.flash.FlashTrayIcon;

@:access(lime.ui.TrayEntry)
@:access(lime.ui.TrayIcon)
@:access(lime.ui.TrayMenu)
@:access(lime._internal.backend.air.AIRTrayEntry)
@:access(lime._internal.backend.air.AIRTrayIcon)
@:access(lime._internal.backend.air.AIRTrayMenu)
class AIRTrayIcon extends FlashTrayIcon
{
	private static var trayIconID = 0;
	private var __systemTrayIcon:SystemTrayIcon;

	public function new(parent:TrayIcon)
	{
		super(parent);

		if (!NativeApplication.supportsSystemTrayIcon)
		{
			return;
		}

		__systemTrayIcon = Std.downcast(NativeApplication.nativeApplication.icon, SystemTrayIcon);

		if (__systemTrayIcon == null)
		{
			return;
		}

		var tooltip = parent.__tooltip;
		var icon = parent.__icon;

		if (icon != null)
		{
			__systemTrayIcon.bitmaps = [cast(icon.src, BitmapData)];
		}
		__systemTrayIcon.tooltip = tooltip;

		parent.id = trayIconID++;
	}

	override public function setIcon(image:Image):Void
	{
		if (image != null)
		{
			__systemTrayIcon.bitmaps = [cast(image.src, BitmapData)];
		}
		else
		{
			__systemTrayIcon.bitmaps = [];
		}
	}

	override public function setTooltip(tooltip:String):Void
	{
		__systemTrayIcon.tooltip = tooltip;
	}

	override public function remove():Void
	{
		__systemTrayIcon.tooltip = null;
		__systemTrayIcon.bitmaps = [];
		__systemTrayIcon = null;
	}

	override public function createMenu():TrayMenu
	{
		var menu = new TrayMenu(parent);
		__systemTrayIcon.menu = menu.__backend.__nativeMenu;
		return menu;
	}
}