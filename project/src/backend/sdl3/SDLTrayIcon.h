#ifndef LIME_SDL_TRAY_ICON_H
#define LIME_SDL_TRAY_ICON_H


#include <SDL3/SDL.h>
#include <graphics/ImageBuffer.h>
#include <ui/TrayIcon.h>
#include <ui/TrayIconEvent.h>
#include <ui/TrayMenu.h>


namespace lime {


	class SDLTrayIcon : public TrayIcon {

		public:

			SDLTrayIcon (ImageBuffer *imageBuffer, const char* title);
			~SDLTrayIcon ();

			virtual void SetIcon (ImageBuffer *imageBuffer);
			virtual const char* SetTooltip (const char* title);
			virtual void Remove ();
			virtual TrayMenu* CreateMenu ();
			SDL_Tray* sdlTray;

			bool Click(int button);

		private:

			// TrayIconEvent trayIconEvent;


	};


}


#endif
