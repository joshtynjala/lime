#ifndef LIME_SDL_TRAY_MENU_H
#define LIME_SDL_TRAY_MENU_H


#include <SDL3/SDL.h>
#include <ui/TrayMenu.h>


namespace lime {


	class SDLTrayMenu : public TrayMenu {

		public:

			SDLTrayMenu (SDL_Tray* sdlTray);
			SDLTrayMenu (SDL_TrayEntry* sdlTrayEntry);
			~SDLTrayMenu ();
			virtual TrayEntry* InsertEntryAt (const char* label, int type, int index);

			SDL_TrayMenu* sdlTrayMenu;

		private:


	};


}


#endif
