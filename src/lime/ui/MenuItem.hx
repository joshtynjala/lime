package lime.ui;

import lime.app.Event;

#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class MenuItem
{
	@:noCompletion private var __backend:MenuItemBackend;
	@:noCompletion private var __text:String;
	@:noCompletion private var __checked:Bool;
	@:noCompletion private var __separator:Bool;
	@:noCompletion private var __submenu:Menu;
	@:noCompletion private var __parent:Menu;
	@:noCompletion private static var __pendingBackendHandle:Dynamic;

	public var text(get, set):String;
	public var checked(get, set):Bool;
	public var separator(get, never):Bool;
	public var submenu(get, set):Menu;
	public var onSelect(default, null) = new Event<Void->Void>();
	public var parent(get, never):Menu;

	public function new(separator:Bool = false) {
		__separator = separator;
		var handle = __pendingBackendHandle;
		__pendingBackendHandle = null;
		__backend = new MenuItemBackend(this, handle);
	}

	private function get_text():String
	{
		return __text;
	}

	private function set_text(value:String):String
	{
		return __text = __backend.setText(value);
	}

	private function get_checked():Bool
	{
		return __checked;
	}

	private function set_checked(value:Bool):Bool
	{
		return __checked = __backend.setChecked(value);
	}

	private function get_separator():Bool
	{
		return __separator;
	}

	private function get_submenu():Menu
	{
		return __submenu;
	}

	private function set_submenu(value:Menu):Menu
	{
		return __submenu = __backend.setSubmenu(value);
	}

	private function get_parent():Menu
	{
		return __parent;
	}
}


#if air
@:noCompletion private typedef MenuItemBackend = lime._internal.backend.air.AIRMenuItem;
#elseif flash
@:noCompletion private typedef MenuItemBackend = lime._internal.backend.flash.FlashMenuItem;
#elseif (js && html5)
@:noCompletion private typedef MenuItemBackend = lime._internal.backend.html5.HTML5MenuItem;
#else
@:noCompletion private typedef MenuItemBackend = lime._internal.backend.native.NativeMenuItem;
#end
