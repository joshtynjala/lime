#ifndef LIME_SDL_TRAY_ENTRY_H
#define LIME_SDL_TRAY_ENTRY_H


#include <SDL3/SDL.h>
#include <system/ValuePointer.h>
#include <ui/TrayEntry.h>
#include <ui/TrayMenu.h>


namespace lime {


	class SDLTrayEntry : public TrayEntry {

		public:

			SDLTrayEntry (SDL_TrayMenu* sdlTrayMenu, const char* label, int type, int index);
			~SDLTrayEntry ();
			virtual const char* SetLabel (const char* text);
			virtual bool SetEnabled (bool enabled);
			virtual bool SetChecked (bool checked);
			virtual void SetCallback (ValuePointer* callback);
			virtual void Remove ();
			virtual TrayMenu* CreateSubMenu();
			void Select();

			SDL_TrayEntry* sdlTrayEntry;

		private:

			ValuePointer* callback;


	};


}


#endif
