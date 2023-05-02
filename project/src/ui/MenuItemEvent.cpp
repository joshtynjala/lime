#include <system/CFFI.h>
#include <ui/MenuItemEvent.h>


namespace lime {


	ValuePointer* MenuItemEvent::callback = 0;
	ValuePointer* MenuItemEvent::eventObject = 0;

	static int id_type;
	static int id_menuItemID;
	static bool init = false;

	MenuItemEvent::MenuItemEvent () {

		type = MENU_ITEM_SELECT;
		menuItemID = 0;

	}


	void MenuItemEvent::Dispatch (MenuItemEvent* event) {

		if (MenuItemEvent::callback) {

			if (MenuItemEvent::eventObject->IsCFFIValue ()) {

				if (!init) {

					id_type = val_id ("type");
					id_menuItemID = val_id ("menuItemID");
					init = true;

				}

				value object = (value)MenuItemEvent::eventObject->Get ();

				alloc_field (object, id_type, alloc_int (event->type));
				alloc_field (object, id_menuItemID, alloc_int (event->menuItemID));

			} else {

				MenuItemEvent* eventObject = (MenuItemEvent*)MenuItemEvent::eventObject->Get ();

				eventObject->type = event->type;
				eventObject->menuItemID = event->menuItemID;

			}

			MenuItemEvent::callback->Call ();

		}

	}

}