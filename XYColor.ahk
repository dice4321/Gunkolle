;XYCOLOR v1.61001

if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}
#Persistent
#SingleInstance
#Include %A_ScriptDir%/Functions/Gdip_All.ahk ;Thanks to tic (Tariq Porter) for his GDI+ Library => ahkscript.org/boards/viewtopic.php?t=6517
CoordMode, Pixel, Relative
CoordMode, Mouse, Relative

IniRead, Background, config.ini, Variables, Background, 1
IniRead, Class, config.ini, Variables, Class, 0

Initialize()

IniRead, WINID, config.ini, Variables, WINID, KancolleViewer!

#Include %A_ScriptDir%/Constants/PixelColor.ahk

SpecificWindows()
Gui, 1: New
Gui, 1: Default
Gui, Add, Text,, FX
Gui, Add, Text,, FY
Gui, Add, Text,, Color
Gui, Add, Edit, r1 w20 vFXB ReadOnly
Gui, Add, Edit, r1 w20 vFYB ReadOnly
Gui, Add, Edit, r1 w20 vColorB ReadOnly
Gui, Add, Edit, r1 w20 vNB ReadOnly
GuiControl, Move, FXB, x40 y5 w70
GuiControl, Move, FYB, x40 y30 w70
GuiControl, Move, ColorB, x40 y55 w70
GuiControl, Move, NB, y90 w300
Gui, Show, Autosize
IniWrite,1,config.ini,Do Not Modify,Busy
Busy := 1
SetWindow()
return

~RButton Up::
{
	if WinExist("A") = uid
	{	
		MouseGetPos, mxp, myp
		tx := mxp - FX
		ty := myp - FY
		if tx > 0
		{
			tx = +%tx%
		}
		if ty > 0
		{
			ty = +%ty%
		}
		GuiControl,, FXB, %tx%
		GuiControl,, FYB, %ty%
		PixelGetColor, PC, mxp, myp, RGB
		GuiControl,, ColorB, %PC%
		
	}
	return
}

#Include %A_ScriptDir%/Functions/Click.ahk
#Include %A_ScriptDir%/Functions/PixelCheck.ahk
#Include %A_ScriptDir%/Functions/Window.ahk
#Include %A_ScriptDir%/Functions/PixelSearch.ahk
#Include %A_ScriptDir%/Functions/PixelMap.ahk
		
Initialize()
{
    global
	return
}

GuiClose:
{
	ExitApp 
}