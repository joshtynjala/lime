package lime._internal.backend.air;

import lime._internal.backend.flash.FlashTrayMenu;
import lime.ui.TrayMenu;
import lime.ui.TrayEntry;
import lime.ui.TrayEntryType;
import lime.ui.TrayIcon;
import flash.display.NativeMenu;

@:access(lime.ui.TrayEntry)
@:access(lime.ui.TrayIcon)
@:access(lime.ui.TrayMenu)
@:access(lime._internal.backend.air.AIRTrayEntry)
@:access(lime._internal.backend.air.AIRTrayIcon)
@:access(lime._internal.backend.air.AIRTrayMenu)
class AIRTrayMenu extends FlashTrayMenu
{
	private var __nativeMenu:NativeMenu;

	public function new(parent:TrayMenu)
	{
		super(parent);
		__nativeMenu = new NativeMenu();
		if (parent.__trayEntry != null)
		{
			parent.__trayEntry.__backend.__nativeMenuItem.submenu = __nativeMenu;
		}
		else
		{
			parent.__trayIcon.__backend.__systemTrayIcon.menu = __nativeMenu;
		}
	}

	override public function insertTrayEntryAt(label:String, type:TrayEntryType, index:Int):TrayEntry
	{
		var trayEntry = new TrayEntry(parent, label, type, index);
		if (index == -1)
		{
			__nativeMenu.addItem(trayEntry.__backend.__nativeMenuItem);
		}
		else
		{
			__nativeMenu.addItemAt(trayEntry.__backend.__nativeMenuItem, index);
		}
		return trayEntry;
	}
}
