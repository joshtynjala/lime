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
@:access(lime.app.Application)
@:access(lime.ui.TrayMenu)
class TrayIcon
{
	@:noCompletion private var __application:Application;
	@:noCompletion private var __backend:TrayIconBackend;
	@:noCompletion private var __removed:Bool;
	@:noCompletion private var __menu:TrayMenu;
	@:noCompletion private var __icon:Image;
	@:noCompletion private var __tooltip:String;

	public var id(default, null):Int;

	public var icon(default, set):Image;
	public var tooltip(default, set):String;

	public var onClick(default, null) = new Event<MouseButton->Void>();

	@:noCompletion private function new(application:Application, attributes:TrayIconAttributes)
	{
		id = -1;
		__removed = false;
		__application = application;

		__icon = attributes.icon;
		__tooltip = attributes.tooltip;

		__backend = new TrayIconBackend(this);
	}

	public function remove():Void
	{
		if (__removed)
		{
			return;
		}
		__removed = true;
		__application.__trayIcons.remove(this);
		__backend.remove();
	}

	public function createMenu():TrayMenu
	{
		if (__menu != null)
		{
			return __menu;
		}
		__menu = __backend.createMenu();
		return __menu;
	}

	private function set_icon(image:Image):Image
	{
		__icon = image;
		__backend.setIcon(__icon);
		return __icon;
	}

	private function set_tooltip(text:String):String
	{
		__tooltip = text;
		__backend.setTooltip(__tooltip);
		return __tooltip;
	}
}

#if air
@:noCompletion private typedef TrayIconBackend = lime._internal.backend.air.AIRTrayIcon;
#elseif flash
@:noCompletion private typedef TrayIconBackend = lime._internal.backend.flash.FlashTrayIcon;
#elseif (js && html5)
@:noCompletion private typedef TrayIconBackend = lime._internal.backend.html5.HTML5TrayIcon;
#else
@:noCompletion private typedef TrayIconBackend = lime._internal.backend.native.NativeTrayIcon;
#end
