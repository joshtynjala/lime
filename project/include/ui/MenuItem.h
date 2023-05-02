#ifndef LIME_UI_MENU_ITEM_H
#define LIME_UI_MENU_ITEM_H

namespace lime {

	class Menu;

	struct MenuItem {

		MenuItem (bool separator) : separator (separator) {
			id = 0;
			text = "";
			checked = false;
			submenu = 0;
		}

		bool separator;
		int id;
		const char* text;
		bool checked;
		Menu* submenu;

	};

}


#endif
