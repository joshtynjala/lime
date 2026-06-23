package lime._internal.backend.native;

import lime.ui.TrayMenu;
import lime.ui.TrayEntry;
import lime.ui.TrayEntryType;

#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
@:access(lime._internal.backend.native.NativeCFFI)
@:access(lime.ui.TrayIcon)
@:access(lime.ui.TrayMenu)
@:access(lime.ui.TrayEntry)
@:access(lime._internal.backend.native.NativeTrayIcon)
@:access(lime._internal.backend.native.NativeTrayEntry)
class NativeTrayMenu
{
	private var parent:TrayMenu;
	public var handle:Dynamic;

	public function new(parent:TrayMenu)
	{
		this.parent = parent;

		#if (lime_cffi && !macro)
		if (parent.__trayEntry != null)
		{
			handle = NativeCFFI.lime_trayicon_create_entry_submenu(parent.__trayEntry.__backend.handle);
		}
		else
		{
			handle = NativeCFFI.lime_trayicon_create_menu(parent.__trayIcon.__backend.handle);
		}
		#end
	}

	public function insertTrayEntryAt(label:String, type:TrayEntryType, index:Int):TrayEntry
	{
		return new TrayEntry(parent, label, type, index);
	}
}
