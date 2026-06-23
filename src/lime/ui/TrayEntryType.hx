package lime.ui;

enum abstract TrayEntryType(Int) to Int
{
	var BUTTON = 0x00000001;
	var CHECKBOX = 0x00000002;
	var SUBMENU = 0x00000004;
}
