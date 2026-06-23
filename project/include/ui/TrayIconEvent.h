#ifndef LIME_UI_TRAY_ICON_EVENT_H
#define LIME_UI_TRAY_ICON_EVENT_H


#include <system/CFFI.h>
#include <system/ValuePointer.h>
#include <stdint.h>


namespace lime {


	enum TrayIconEventType {

		TRAY_ICON_LEFT_CLICK,
		TRAY_ICON_RIGHT_CLICK,
		TRAY_ICON_MIDDLE_CLICK

	};


	struct TrayIconEvent {

		hl_type* t;
		TrayIconEventType type;
		int trayIconID;

		static ValuePointer* callback;
		static ValuePointer* eventObject;

		TrayIconEvent ();

		static void Dispatch (TrayIconEvent* event);

	};


}


#endif