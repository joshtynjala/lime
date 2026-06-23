#include "SDLTrayIcon.h"
#include "SDLTrayMenu.h"



namespace lime {


	// bool SDLCALL SDLTrayLeftClickCallback(void *userdata, SDL_Tray *tray) {

	// 	SDLTrayIcon* trayIcon = (SDLTrayIcon*)userdata;
	// 	return trayIcon->Click(0);

	// }


	// bool SDLCALL SDLTrayRightClickCallback(void *userdata, SDL_Tray *tray) {

	// 	SDLTrayIcon* trayIcon = (SDLTrayIcon*)userdata;
	// 	return trayIcon->Click(2);

	// }


	// bool SDLCALL SDLTrayMiddleClickCallback(void *userdata, SDL_Tray *tray) {

	// 	SDLTrayIcon* trayIcon = (SDLTrayIcon*)userdata;
	// 	return trayIcon->Click(1);

	// }


	SDLTrayIcon::SDLTrayIcon (ImageBuffer *imageBuffer, const char* tooltip) {

		SDL_Surface* surface = NULL;

		if (imageBuffer) {

			surface = SDL_CreateSurfaceFrom (imageBuffer->width, imageBuffer->height, SDL_GetPixelFormatForMasks (imageBuffer->bitsPerPixel, 0x000000FF, 0x0000FF00, 0x00FF0000, 0xFF000000), imageBuffer->data->buffer->b, imageBuffer->Stride ());

		}

		sdlTray = SDL_CreateTray(surface, tooltip);

		// TrayIcon click events require SDL 3.4
		// SDL_PropertiesID props = SDL_CreateProperties();
		// SDL_SetPointerProperty(props, SDL_PROP_TRAY_CREATE_USERDATA_POINTER, this);
		// SDL_SetPointerProperty(props, SDL_PROP_TRAY_CREATE_ICON_POINTER, surface);
		// SDL_SetStringProperty(props, SDL_PROP_TRAY_CREATE_TOOLTIP_STRING, tooltip);
		// SDL_SetPointerProperty(props, SDL_PROP_TRAY_CREATE_LEFTCLICK_CALLBACK_POINTER, (void*)SDLTrayLeftClickCallback);
		// SDL_SetPointerProperty(props, SDL_PROP_TRAY_CREATE_RIGHTCLICK_CALLBACK_POINTER, (void*)SDLTrayRightClickCallback);
		// SDL_SetPointerProperty(props, SDL_PROP_TRAY_CREATE_MIDDLECLICK_CALLBACK_POINTER, (void*)SDLTrayMiddleClickCallback);
		// sdlTray = SDL_CreateTrayWithProperties (props);
		// SDL_DestroyProperties(props);

		if (surface) {

			SDL_DestroySurface (surface);

		}

		if (!sdlTray) {

			printf ("Could not create SDL tray: %s.\n", SDL_GetError ());
			return;

		}

	}


	SDLTrayIcon::~SDLTrayIcon () {

		Remove();

	}


	void SDLTrayIcon::Remove () {

		if (sdlTray) {

			SDL_DestroyTray (sdlTray);
			sdlTray = 0;

		}

	}


	void SDLTrayIcon::SetIcon (ImageBuffer *imageBuffer) {

		SDL_Surface* surface = NULL;

		if (imageBuffer) {

			surface = SDL_CreateSurfaceFrom (imageBuffer->width, imageBuffer->height, SDL_GetPixelFormatForMasks (imageBuffer->bitsPerPixel, 0x000000FF, 0x0000FF00, 0x00FF0000, 0xFF000000), imageBuffer->data->buffer->b, imageBuffer->Stride ());

		}

		// may be set to NULL
		SDL_SetTrayIcon (sdlTray, surface);

		if (surface) {

			SDL_DestroySurface (surface);

		}
	}


	const char* SDLTrayIcon::SetTooltip (const char* tooltip) {

		SDL_SetTrayTooltip (sdlTray, tooltip);

		return tooltip;

	}


	TrayMenu* SDLTrayIcon::CreateMenu () {

		return new SDLTrayMenu(sdlTray);

	}


	// bool SDLTrayIcon::Click(int button) {

	// 	switch (button)
	// 	{

	// 		case 0:

	// 			trayIconEvent.type = TRAY_ICON_LEFT_CLICK;
	// 			TrayIconEvent::Dispatch(&trayIconEvent);

	// 			break;

	// 		case 1:

	// 			trayIconEvent.type = TRAY_ICON_RIGHT_CLICK;
	// 			TrayIconEvent::Dispatch(&trayIconEvent);

	// 			break;

	// 		case 2:

	// 			trayIconEvent.type = TRAY_ICON_MIDDLE_CLICK;
	// 			TrayIconEvent::Dispatch(&trayIconEvent);

	// 			break;

	// 	}

	// 	return true;

	// }


	TrayIcon* CreateTrayIcon (ImageBuffer *imageBuffer, const char* tooltip) {

		SDLTrayIcon* trayIcon = new SDLTrayIcon (imageBuffer, tooltip);

		if (!trayIcon->sdlTray) {

			delete trayIcon;
			return 0;

		}

		return trayIcon;

	}


}
