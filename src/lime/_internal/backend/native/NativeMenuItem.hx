package lime._internal.backend.native;

import lime.ui.Menu;
import lime.ui.MenuItem;

@:access(lime.ui.Menu)
@:access(lime.ui.MenuItem)
@:access(lime._internal.backend.native.NativeMenu)
@:access(lime._internal.backend.native.NativeCFFI)
class NativeMenuItem
{
	private static var nextID:Int = 9001;

	public var id:Int;
	public var handle:Dynamic;

	private var parent:MenuItem;

	public function new(parent:MenuItem, ?handle:Dynamic)
	{
		this.parent = parent;

		id = nextID;
		nextID++;

		if (handle != null)
		{
			#if (!macro && lime_cffi)
			parent.__separator = NativeCFFI.lime_menu_item_get_separator(handle);

			#if hl
			var utf = NativeCFFI.lime_menu_item_get_text(handle);
			if (utf != null)
			{
				parent.__text = @:privateAccess String.fromUTF8(utf);
			}
			#else
			parent.__text = NativeCFFI.lime_menu_item_get_text(handle);
			#end
			parent.__checked = NativeCFFI.lime_menu_item_get_checked(handle);
			var submenuHandle = NativeCFFI.lime_menu_item_get_submenu_from_native(handle);
			if (submenuHandle != null)
			{
				Menu.__pendingBackendHandle = submenuHandle;
				parent.__submenu = new Menu();
			}
			#end
		}
		else
		{
			#if (!macro && lime_cffi)
			handle = NativeCFFI.lime_menu_item_create(parent.__separator);
			#end
		}
		#if (!macro && lime_cffi)
		NativeCFFI.lime_menu_item_set_id(handle, id);
		#end
		this.handle = handle;
	}

	public function getText():String
	{
		if (handle != null)
		{
			#if (!macro && lime_cffi)
			#if hl
			var utf = NativeCFFI.lime_menu_item_get_text(handle);
			if (utf != null)
			{
				return @:privateAccess String.fromUTF8(utf);
			}
			return "";
			#else
			return NativeCFFI.lime_menu_item_get_text(handle);
			#end
			#end
		}
		return null;
	}

	public function setText(text:String):String
	{
		if (handle != null)
		{
			#if (!macro && lime_cffi)
			NativeCFFI.lime_menu_item_set_text(handle, text);
			var parentMenu = parent.parent;
			if (parentMenu != null)
			{
				NativeCFFI.lime_menu_refresh_items(parentMenu.__backend.handle);
			}
			#end
		}
		return text;
	}

	public function getChecked():Bool
	{
		if (handle != null)
		{
			#if (!macro && lime_cffi)
			return NativeCFFI.lime_menu_item_get_checked(handle);
			#end
		}
		return false;
	}

	public function setChecked(checked:Bool):Bool
	{
		if (handle != null)
		{
			#if (!macro && lime_cffi)
			NativeCFFI.lime_menu_item_set_checked(handle, checked);
			var parentMenu = parent.parent;
			if (parentMenu != null)
			{
				NativeCFFI.lime_menu_refresh_items(parentMenu.__backend.handle);
			}
			#end
		}
		return checked;
	}

	public function setSubmenu(menu:Menu):Menu
	{
		if (handle != null)
		{
			#if (!macro && lime_cffi)
			NativeCFFI.lime_menu_item_set_submenu(handle, menu.__backend.handle);
			var parentMenu = parent.parent;
			if (parentMenu != null)
			{
				NativeCFFI.lime_menu_refresh_items(parentMenu.__backend.handle);
			}
			#end
		}
		return menu;
	}
}
