package lime._internal.backend.air;

import lime._internal.backend.flash.FlashTrayEntry;
import lime.ui.TrayEntry;
import lime.ui.TrayEntryType;
import lime.ui.TrayMenu;
import flash.display.NativeMenuItem;
import flash.events.Event;

@:access(lime.ui.TrayEntry)
@:access(lime.ui.TrayIcon)
@:access(lime.ui.TrayMenu)
@:access(lime._internal.backend.air.AIRTrayEntry)
@:access(lime._internal.backend.air.AIRTrayIcon)
@:access(lime._internal.backend.air.AIRTrayMenu)
class AIRTrayEntry extends FlashTrayEntry
{
	private var __nativeMenuItem:NativeMenuItem;

	public function new(parent:TrayEntry, index:Int)
	{
		super(parent, index);

		var label = parent.__label;

		__nativeMenuItem = new NativeMenuItem(label == null ? "" : label, label == null);
		__nativeMenuItem.addEventListener(Event.SELECT, handleTrayEntrySelect);
	}

	override public function remove():Void
	{
		if (__nativeMenuItem.menu == null)
		{
			return;
		}
		__nativeMenuItem.menu.removeItem(__nativeMenuItem);
		__nativeMenuItem = null;
	}

	override public function setLabel(label:String):Void
	{
		__nativeMenuItem.label = label;
	}

	override public function setEnabled(enabled:Bool):Void
	{
		__nativeMenuItem.enabled = enabled;
	}

	override public function setChecked(checked:Bool):Void
	{
		__nativeMenuItem.checked = checked;
	}

	override public function createSubMenu():TrayMenu
	{
		return new TrayMenu(null, parent);
	}

	private function handleTrayEntrySelect(event:Event):Void
	{
		parent.onSelect.dispatch(parent);
	}
}
