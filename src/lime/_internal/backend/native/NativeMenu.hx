package lime._internal.backend.native;

import lime._internal.backend.native.NativeCFFI;
import lime.ui.Menu;
import lime.ui.MenuItem;

@:access(lime.ui.Menu)
@:access(lime.ui.MenuItem)
@:access(lime._internal.backend.native.NativeCFFI)
@:access(lime._internal.backend.native.NativeMenuItem)
class NativeMenu
{
	public var handle:Dynamic;

	private var parent:Menu;

	public function new(parent:Menu, handle:Dynamic)
	{
		this.parent = parent;
		if (handle != null)
		{
			#if (lime_cffi && !macro)
			#if hl
			var menuItemHandles:hl.NativeArray<Dynamic> = NativeCFFI.lime_menu_get_items_from_native(handle);
			#else
			var menuItemHandles:Array<Dynamic> = NativeCFFI.lime_menu_get_items_from_native(handle);
			#end
			if (menuItemHandles != null)
			{
				var items:Array<MenuItem> = [];
				for (i in 0...menuItemHandles.length)
				{
					var menuItemHandle = menuItemHandles[i];
					MenuItem.__pendingBackendHandle = menuItemHandle;
					items[i] = new MenuItem();
				}
				parent.__items = items;
			}
			#end
		}
		else
		{
			#if (!macro && lime_cffi)
			handle = NativeCFFI.lime_menu_create();
			#end
		}
		this.handle = handle;
	}

	public function setItems(items:Array<MenuItem>):Void
	{
		if (handle != null)
		{
			#if (!macro && lime_cffi)
			var itemHandles = items.map(function(item:MenuItem):Dynamic
			{
				return item.__backend.handle;
			});
			#if hl
			var _itemHandles = new hl.NativeArray<Dynamic>(itemHandles.length);
			for (i in 0...itemHandles.length)
			{
				_itemHandles[i] = itemHandles[i];
			}
			NativeCFFI.lime_menu_set_items(handle, _itemHandles);
			#else
			NativeCFFI.lime_menu_set_items(handle, itemHandles);
			#end
			#end
		}
	}
}
