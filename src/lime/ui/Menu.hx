package lime.ui;

#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
@:access(lime.ui.MenuItem)
class Menu
{
	@:noCompletion private var __backend:MenuBackend;
	@:noCompletion private var __items:Array<MenuItem> = [];
	@:noCompletion private static var __pendingBackendHandle:Dynamic;

	public var items(get, set):Array<MenuItem>;

	public function new() {
		var handle = __pendingBackendHandle;
		__pendingBackendHandle = null;
		__backend = new MenuBackend(this, handle);
	}

	private function get_items():Array<MenuItem> {
		return __items;
	}

	private function set_items(value:Array<MenuItem>):Array<MenuItem> {
		for (item in __items)
		{
			item.__parent = null;
		}
		__items = value;
		for (item in __items)
		{
			if (item.parent != null)
			{
				throw new haxe.Exception("A menu item must be added to a menu only once, and it cannot be added to multiple menus");
			}
			item.__parent = this;
		}
		__backend.setItems(__items);
		return __items;
	}
}


#if air
@:noCompletion private typedef MenuBackend = lime._internal.backend.air.AIRMenu;
#elseif flash
@:noCompletion private typedef MenuBackend = lime._internal.backend.flash.FlashMenu;
#elseif (js && html5)
@:noCompletion private typedef MenuBackend = lime._internal.backend.html5.HTML5Menu;
#else
@:noCompletion private typedef MenuBackend = lime._internal.backend.native.NativeMenu;
#end
