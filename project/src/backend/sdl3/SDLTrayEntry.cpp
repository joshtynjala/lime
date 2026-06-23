#include "SDLTrayEntry.h"
#include "SDLTrayMenu.h"



namespace lime {

	void SDLCALL SDLTrayEntryCallback(void *userdata, SDL_TrayEntry *entry) {

		SDLTrayEntry* trayEntry = (SDLTrayEntry*)userdata;
		return trayEntry->Select();

	}


	SDLTrayEntry::SDLTrayEntry (SDL_TrayMenu* sdlTrayMenu, const char* label, int type, int index) {

		sdlTrayEntry = SDL_InsertTrayEntryAt (sdlTrayMenu, index, label, type);
		callback = 0;

		if (!sdlTrayEntry) {

			printf ("Could not create SDL tray entry: %s.\n", SDL_GetError ());
			return;

		}

		SDL_SetTrayEntryCallback(sdlTrayEntry, SDLTrayEntryCallback, this);

	}


	SDLTrayEntry::~SDLTrayEntry () {

		// cleaning up the SDL_Tray will clean up the SDL_TrayEntry too

		if (callback)
		{
			delete callback;
			callback = 0;
		}

	}


	void SDLTrayEntry::Remove () {

		if (sdlTrayEntry) {

			SDL_RemoveTrayEntry (sdlTrayEntry);
			sdlTrayEntry = 0;

		}

	}


	const char* SDLTrayEntry::SetLabel (const char* label) {

		SDL_SetTrayEntryLabel (sdlTrayEntry, label);

		return label;

	}


	bool SDLTrayEntry::SetEnabled (bool enabled) {

		SDL_SetTrayEntryEnabled (sdlTrayEntry, enabled);

		return enabled;

	}


	bool SDLTrayEntry::SetChecked (bool checked) {

		SDL_SetTrayEntryChecked (sdlTrayEntry, checked);

		return checked;

	}


	void SDLTrayEntry::SetCallback (ValuePointer* callback) {

		this->callback = callback;

	}

	void SDLTrayEntry::Select ()
	{
		if (callback)
		{
			callback->Call ();
		}
	}


	TrayMenu* SDLTrayEntry::CreateSubMenu () {

		return new SDLTrayMenu(sdlTrayEntry);

	}


}
