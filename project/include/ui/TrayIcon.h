#ifndef LIME_UI_TRAY_ICON_H
#define LIME_UI_TRAY_ICON_H



#include <graphics/ImageBuffer.h>
#include <system/CFFI.h>
#include <ui/TrayMenu.h>
#include <stdint.h>



namespace lime {


	class TrayIcon {


		public:

			virtual ~TrayIcon () {};


			virtual void SetIcon (ImageBuffer *imageBuffer) = 0;
			virtual const char* SetTooltip (const char* tooltip) = 0;
			virtual void Remove () = 0;
			virtual TrayMenu* CreateMenu () = 0;


	};


	TrayIcon* CreateTrayIcon (ImageBuffer *imageBuffer, const char* tooltip);

}


#endif
