package lime._internal.backend.native;

import lime.ui.TrayMenu;
import lime.ui.TrayEntry;
import lime.ui.TrayEntryType;

#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
@:access(lime._internal.backend.native.NativeCFFI)
@:access(lime.ui.TrayEntry)
@:access(lime.ui.TrayMenu)
class NativeTrayEntry
{
	private var parent:TrayEntry;
	private var handle:Dynamic;

	public function new(parent:TrayEntry, index:Int)
	{
		this.parent = parent;

		var label = parent.__label;
		var type = parent.__type;

		#if (lime_cffi && !macro)
		handle = NativeCFFI.lime_trayicon_create_entry(parent.__trayMenu.__backend.handle, label, type, index);
		if (handle != null)
		{
			NativeCFFI.lime_trayicon_set_entry_callback(handle, handleTrayEntrySelect);
		}
		#end
	}

	public function remove():Void
	{
		#if (lime_cffi && !macro)
		NativeCFFI.lime_trayicon_remove_entry(handle);
		#end
	}

	public function setLabel(label:String):Void
	{
		#if (lime_cffi && !macro)
		NativeCFFI.lime_trayicon_set_entry_label(handle, label);
		#end
	}

	public function setEnabled(enabled:Bool):Void
	{
		#if (lime_cffi && !macro)
		NativeCFFI.lime_trayicon_set_entry_enabled(handle, enabled);
		#end
	}

	public function setChecked(checked:Bool):Void
	{
		#if (lime_cffi && !macro)
		NativeCFFI.lime_trayicon_set_entry_checked(handle, checked);
		#end
	}

	public function createSubMenu():TrayMenu
	{
		return new TrayMenu(null, parent);
	}

	private function handleTrayEntrySelect():Void
	{
		parent.onSelect.dispatch(parent);
	}
}
