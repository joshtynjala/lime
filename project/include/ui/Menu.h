#ifndef LIME_UI_MENU_H
#define LIME_UI_MENU_H

#include <ui/MenuItem.h>
#ifdef HX_WINDOWS
#include <Windows.h>
#endif

namespace lime {

	class Menu {


		public:

			Menu ();
			#ifdef HX_MACOS
			Menu (void* nativeMenu);
			#endif
			~Menu ();
			MenuItem** GetItems(int &numItems);
			void SetItems (MenuItem** items, int numItems);
			void RefreshItems ();
			void SetAsAppMenu ();

			static Menu* CreateAppMenu ();

			#ifdef HX_WINDOWS
			HWND nativeWindow;
			HMENU nativeMenu;
			#else
			void* nativeMenu;
			#endif

			Menu* parentMenu;

		private:

			int menuItemsLength;
			MenuItem** menuItems;

			#ifdef HX_MACOS
			void PopulateNativeItems();
			#endif

	};

}


#endif
