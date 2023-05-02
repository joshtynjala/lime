#ifndef LIME_UI_MENU_ITEM_EVENT_H
#define LIME_UI_MENU_ITEM_EVENT_H


#include <system/CFFI.h>
#include <system/ValuePointer.h>
#include <stdint.h>


namespace lime {


	enum MenuItemEventType {

		MENU_ITEM_SELECT,

	};


	struct MenuItemEvent {

		hl_type* t;
		MenuItemEventType type;
		int menuItemID;

		static ValuePointer* callback;
		static ValuePointer* eventObject;

		MenuItemEvent ();

		static void Dispatch (MenuItemEvent* event);

	};


}


#endif