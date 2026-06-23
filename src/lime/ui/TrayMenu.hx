package lime.ui;

#if hl
@:keep
#end
#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
@:access(lime.ui.TrayIcon)
@:access(lime.ui.TrayEntry)
class TrayMenu
{
	@:noCompletion private var __backend:TrayMenuBackend;
	@:noCompletion private var __trayIcon:TrayIcon;
	@:noCompletion private var __trayEntry:TrayEntry;
	@:noCompletion private var __trayEntries:Array<TrayEntry>;

	public var parentTrayIcon(get, never):TrayIcon;

	public var parentTrayEntry(get, never):TrayEntry;

	private function new(trayIcon:TrayIcon, trayEntry:TrayEntry = null)
	{
		__trayIcon = trayIcon;
		__trayEntry = trayEntry;

		__trayEntries = [];

		__backend = new TrayMenuBackend(this);
	}

	public function getTrayEntries():Array<TrayEntry>
	{
		return __trayEntries.copy();
	}

	public function insertTrayEntry(label:String, type:TrayEntryType = BUTTON):TrayEntry
	{
		return insertTrayEntryAt(label, type, -1);
	}

	public function insertTrayEntryAt(label:String, type:TrayEntryType = BUTTON, index:Int):TrayEntry
	{
		var trayEntry = __backend.insertTrayEntryAt(label, type, index);
		if (trayEntry == null)
		{
			return null;
		}
		if (index == -1)
		{
			__trayEntries.push(trayEntry);
		}
		else
		{
			__trayEntries.insert(index, trayEntry);
		}
		return trayEntry;
	}

	private function get_parentTrayIcon():TrayIcon
	{
		return __trayIcon;
	}

	private function get_parentTrayEntry():TrayEntry
	{
		return __trayEntry;
	}
}

#if air
@:noCompletion private typedef TrayMenuBackend = lime._internal.backend.air.AIRTrayMenu;
#elseif flash
@:noCompletion private typedef TrayMenuBackend = lime._internal.backend.flash.FlashTrayMenu;
#elseif (js && html5)
@:noCompletion private typedef TrayMenuBackend = lime._internal.backend.html5.HTML5TrayMenu;
#else
@:noCompletion private typedef TrayMenuBackend = lime._internal.backend.native.NativeTrayMenu;
#end
