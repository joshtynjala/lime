#ifndef LIME_UI_TRAY_MENU_H
#define LIME_UI_TRAY_MENU_H



#include <system/CFFI.h>
#include <ui/TrayEntry.h>



namespace lime {

	class TrayEntry;


	class TrayMenu {


		public:

			virtual ~TrayMenu () {};
			virtual TrayEntry* InsertEntryAt (const char* label, int type, int index) = 0;


	};

}


#endif
