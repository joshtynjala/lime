#include <system/CFFI.h>
#include <ui/TrayIconEvent.h>


namespace lime {


	ValuePointer* TrayIconEvent::callback = 0;
	ValuePointer* TrayIconEvent::eventObject = 0;

	static int id_type;
	static int id_trayIconID;
	static bool init = false;


	TrayIconEvent::TrayIconEvent () {

		type = TRAY_ICON_LEFT_CLICK;

		id_trayIconID = 0;

	}


	void TrayIconEvent::Dispatch (TrayIconEvent* event) {

		if (TrayIconEvent::callback) {

			if (TrayIconEvent::eventObject->IsCFFIValue ()) {

				if (!init) {

					id_type = val_id ("type");
					id_trayIconID = val_id ("trayIconID");
					init = true;

				}

				value object = (value)TrayIconEvent::eventObject->Get ();

				alloc_field (object, id_type, alloc_int (event->type));
				alloc_field (object, id_trayIconID, alloc_int (event->trayIconID));

			} else {

				TrayIconEvent* eventObject = (TrayIconEvent*)TrayIconEvent::eventObject->Get ();

				eventObject->type = event->type;
				eventObject->trayIconID = event->trayIconID;

			}

			TrayIconEvent::callback->Call ();

		}

	}


}