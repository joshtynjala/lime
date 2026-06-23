#include "SDLTrayMenu.h"
#include "SDLTrayEntry.h"



namespace lime {


	SDLTrayMenu::SDLTrayMenu (SDL_Tray* sdlTray) {

		sdlTrayMenu = SDL_CreateTrayMenu (sdlTray);

		if (!sdlTrayMenu) {

			printf ("Could not create SDL tray menu: %s.\n", SDL_GetError ());
			return;

		}

	}


	SDLTrayMenu::SDLTrayMenu (SDL_TrayEntry* sdlTrayEntry) {

		sdlTrayMenu = SDL_CreateTraySubmenu (sdlTrayEntry);

		if (!sdlTrayMenu) {

			printf ("Could not create SDL tray menu: %s.\n", SDL_GetError ());
			return;

		}

	}


	SDLTrayMenu::~SDLTrayMenu () {

		// cleaning up the SDL_Tray will clean up the SDL_TrayEntry too

	}

	TrayEntry* SDLTrayMenu::InsertEntryAt (const char* label, int type, int index)
	{

		return new SDLTrayEntry(sdlTrayMenu, label, type, index);

	}


}
