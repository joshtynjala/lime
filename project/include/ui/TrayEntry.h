#ifndef LIME_UI_TRAY_ENTRY_H
#define LIME_UI_TRAY_ENTRY_H



#include <system/CFFI.h>
#include <system/ValuePointer.h>
#include <ui/TrayMenu.h>



namespace lime {

	class TrayMenu;


	class TrayEntry {


		public:

			virtual ~TrayEntry () {};
			virtual const char* SetLabel (const char* text) = 0;
			virtual bool SetEnabled (bool enabled) = 0;
			virtual bool SetChecked (bool checked) = 0;
			virtual void SetCallback (ValuePointer* callback) = 0;
			virtual void Remove () = 0;
			virtual TrayMenu* CreateSubMenu() = 0;


	};

}


#endif
