package lime.ui;

import lime.graphics.Image;
import lime.app.Application;
import lime.app.Event;

#if hl
@:keep
#end
#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
@:access(lime.ui.TrayIcon)
@:access(lime.ui.TrayMenu)
class TrayEntry
{
	@:noCompletion private var __backend:TrayEntryBackend;
	@:noCompletion private var __trayMenu:TrayMenu;
	@:noCompletion private var __type:TrayEntryType;
	@:noCompletion private var __label:String;
	@:noCompletion private var __checked:Bool;
	@:noCompletion private var __enabled:Bool;
	@:noCompletion private var __removed:Bool;

	public var parent(get, never):TrayMenu;

	public var label(get, set):String;

	public var checked(get, set):Bool;

	public var enabled(get, set):Bool;

	public var onSelect(default, null) = new Event<TrayEntry->Void>();

	private function new(trayMenu:TrayMenu, label:String, type:TrayEntryType, index:Int)
	{
		__trayMenu = trayMenu;
		__removed = false;
		__label = label;
		__type = type;
		__checked = false;
		__enabled = true;
		__backend = new TrayEntryBackend(this, index);
	}

	public function remove():Void
	{
		if (__removed)
		{
			return;
		}
		__removed = true;
		__backend.remove();
		__trayMenu.__trayEntries.remove(this);
	}

	public function createSubMenu():TrayMenu
	{
		return __backend.createSubMenu();
	}

	private function get_parent():TrayMenu
	{
		return __trayMenu;
	}

	private function get_label():String
	{
		return __label;
	}

	private function set_label(value:String):String
	{
		__label = value;
		__backend.setLabel(value);
		return __label;
	}

	private function get_checked():Bool
	{
		return __checked;
	}

	private function set_checked(value:Bool):Bool
	{
		__checked = value;
		__backend.setChecked(value);
		return __checked;
	}

	private function get_enabled():Bool
	{
		return __enabled;
	}

	private function set_enabled(value:Bool):Bool
	{
		__enabled = value;
		__backend.setEnabled(value);
		return __enabled;
	}
}
#if air
@:noCompletion private typedef TrayEntryBackend = lime._internal.backend.air.AIRTrayEntry;
#elseif flash
@:noCompletion private typedef TrayEntryBackend = lime._internal.backend.flash.FlashTrayEntry;
#elseif (js && html5)
@:noCompletion private typedef TrayEntryBackend = lime._internal.backend.html5.HTML5TrayEntry;
#else
@:noCompletion private typedef TrayEntryBackend = lime._internal.backend.native.NativeTrayEntry;
#end
