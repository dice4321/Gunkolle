;Window v1.03 11/14/15

CheckWindow()
{
	global
	IfWinExist, ahk_id %uid%
	{
		WinActivateRestore()
		WinGetPos, , , TWinW, TWinH
		if (TWinW != WinW or TWinH != WinH)
		{
			GuiControl,, NB, Window size changed, reinitializing pixel map
			Sleep 1000
			RPixelSearch()
		}
	}
	else
	{
		GuiControl,, NB, Window not found, searching for window
		Sleep 1000
		SetWindow()
	}
	return
}
	
SetWindow()
{
	global
	local i := 1
	Sleep 300
	Loop
	{
		uid := 0
		uid := WinExist(WINID)
		if not uid = 0
		{
			WinActivateRestore(1)
			WinGetPos, , , WinW, WinH
			GuiControl,, NB, Window found
			Break
		}    
		else
		{
			GuiControl,, NB, Window not found. Retrying (%i%)
			Sleep 1000
			i += 1
			if i > 30
			{
				GuiControl,, NB, Could not find window, unpause script to try again
				i := 1
				Pause
			}
		}
	}
	RPixelSearch()
}

WinActivateRestore(force := 0)
{
	global Background
	global uid
	
	WinGet, MMX, MinMax, ahk_id %uid%
	if MMX = -1
	{
		WinRestore
		Sleep 500
	}
	if WinActive(ahk_id %uid%)
	{
	}
	else if (Background = 0 or force = 1)
	{
		WinActivate
		Sleep 500
	}
	return
}

SpecificWindows()
{
	global Background
	if A_OSVersion in WIN_NT4,WIN_95,WIN_98,WIN_ME,WIN_XP
	{
		if Background = 1
		{
			MsgBox This version of Windows is unsupported. Script may not function properly.
			Background := 0
			IniWrite,%Background%,config.ini,Variables,Background
		}
	}
	return
}