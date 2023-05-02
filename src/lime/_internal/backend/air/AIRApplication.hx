package lime._internal.backend.air;

import flash.desktop.NativeApplication;
import flash.desktop.SystemIdleMode;
import flash.events.Event;
import lime._internal.backend.flash.FlashApplication;
import lime.app.Application;
import lime.system.System;
import lime.ui.Menu;

@:access(lime.app.Application)
@:access(lime.ui.Menu)
@:access(lime._internal.backend.air.AIRMenu)
class AIRApplication extends FlashApplication
{
	public function new(parent:Application):Void
	{
		super(parent);

		Menu.__pendingBackendHandle = NativeApplication.nativeApplication.menu;
		NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		NativeApplication.nativeApplication.addEventListener(Event.EXITING, handleExitEvent);
	}

	public override function exec():Int
	{
		if (parent.__menu == null)
		{
			parent.__menu = new Menu();
		}
		return super.exec();
	}

	private function handleExitEvent(event:Event):Void
	{
		System.exit(0);

		if (Application.current != null && Application.current.onExit.canceled)
		{
			event.preventDefault();
			event.stopImmediatePropagation();
		}
	}

	public override function exit():Void
	{
		// TODO: Remove event handlers?
	}

	public override function refreshMenu(menu:Menu):Void
	{
		menu.__items = menu.__backend.refreshMenuItems(menu.__items);
	}

	public override function setMenu(menu:Menu):Void
	{
		NativeApplication.nativeApplication.menu = menu != null ? menu.__backend.nativeMenu : null;
	}
}
