package lime._internal.backend.native;

import lime.graphics.Image;
import lime.ui.TrayEntry;
import lime.ui.TrayIconAttributes;
import lime.ui.TrayIcon;
import lime.ui.TrayMenu;
import lime.ui.MouseButton;

#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
@:access(lime._internal.backend.native.NativeCFFI)
@:access(lime.ui.TrayIcon)
@:access(lime.ui.TrayMenu)
class NativeTrayIcon
{
	private static var trayIconID = 0;

	public var handle:Dynamic;
	private var parent:TrayIcon;
	private var trayIconEventInfo = new TrayIconEventInfo();

	public function new(parent:TrayIcon)
	{
		this.parent = parent;

		var icon = parent.__icon;
		var tooltip = parent.__tooltip;

		#if (lime_cffi && !macro)
		handle = NativeCFFI.lime_trayicon_create(icon != null ? icon.buffer : null, tooltip);
		#end

		if (handle == null)
		{
			return;
		}

		parent.id = trayIconID++;
	}

	public function setIcon(image:Image):Void
	{
		#if (lime_cffi && !macro)
		NativeCFFI.lime_trayicon_set_icon(handle, image != null ? image.buffer : null);
		#end
	}

	public function setTooltip(tooltip:String):Void
	{
		#if (lime_cffi && !macro)
		NativeCFFI.lime_trayicon_set_tooltip(handle, tooltip);
		#end
	}

	public function remove():Void
	{
		#if (lime_cffi && !macro)
		NativeCFFI.lime_trayicon_remove(handle);
		#end
	}

	public function createMenu():TrayMenu
	{
		return new TrayMenu(parent);
	}

	private function handleTrayIconEvent():Void
	{
		switch (trayIconEventInfo.type)
		{
			case TRAY_ICON_LEFT_CLICK:
				parent.onClick.dispatch(MouseButton.LEFT);
			case TRAY_ICON_RIGHT_CLICK:
				parent.onClick.dispatch(MouseButton.RIGHT);
			case TRAY_ICON_MIDDLE_CLICK:
				parent.onClick.dispatch(MouseButton.MIDDLE);
		}
	}
}

@:keep /*private*/ class TrayIconEventInfo
{
	public var type:TrayIconEventType;

	public function new(type:TrayIconEventType = null)
	{
		this.type = type;
	}

	public function clone():TrayIconEventInfo
	{
		return new TrayIconEventInfo(type);
	}
}

private enum abstract TrayIconEventType(Int)
{
	var TRAY_ICON_LEFT_CLICK = 0;
	var TRAY_ICON_RIGHT_CLICK = 1;
	var TRAY_ICON_MIDDLE_CLICK = 2;
}