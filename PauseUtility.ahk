;Pause Utility v1.60813

if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

#Persistent

IniRead, PauseHr, config.ini, Variables, PauseHr, -1
IniRead, PauseMn, config.ini, Variables, PauseMn, -1
IniRead, ResumeHr, config.ini, Variables, ResumeHr, -1
IniRead, ResumeMn, config.ini, Variables, ResumeMn, -1
IniRead, PCSleep, config.ini, Variables, PCSleep, 0
IniRead, NotificationLevel, config.ini, Variables, NotificationLevel, 1

Resume := 0
tString := ""

if (PauseHr = -1 or PauseHr < 0 or PauseHr > 23 or PauseMn = -1 or PauseMn < 0 or PauseMn > 59)
{
	MsgBox PauseHr and PauseMn not set in config.ini file or invalid time input.
	ExitApp
}
else
{
	tt := GetRemainingTime(PauseHr,PauseMn)
	SetTimer, TogglePause, %tt%
	tString := "Script will be paused at " . PauseHr . ":" . PauseMn
}

if not (ResumeHr = -1 or ResumeHr < 0 or ResumeHr > 23 or ResumeMn = -1 or ResumeMn < 0 or ResumeMn > 59)
{
	Resume := 1
	tt := GetRemainingTime(ResumeHr,ResumeMn)
	SetTimer, ToggleResume, %tt%
	tString := tString . " and resumed at " . ResumeHr . ":" . ResumeMn
}

Notify("Pause Utility", tString,1)

return

GetRemainingTime(hr,mn)
{
	global
	if (hr < A_Hour)
	{
		TRH := 24 - A_Hour + hr
	}
	else
	{
		TRH := hr - A_Hour
	}

	if (mn < A_Min)
	{
		TRM := 60 - A_Min + mn
		TRH := TRH - 1
		if (TRH < 0)
		{
			TRH := 24 + TRH
		}
	}
	else
	{
		TRM := mn - A_Min
	}

	TR := TRH * 3600000 + TRM * 60000
	return TR
}

TogglePause:
{
	SetTimer, TogglePause, Off
	DetectHiddenWindows, On
	SetTitleMatchMode 2
	WinGet, ahkc_id, ID, AHKanColle ahk_class AutoHotkeyGUI
	WinGet, ahkcs_id, ID, AHKCSortie ahk_class AutoHotkeyGUI
	PostMessage, 0x111, 65306,,, ahk_id %ahkc_id%
	PostMessage, 0x111, 65306,,, ahk_id %ahkcs_id%
	Notify("Pause Utility", "Paused",1)
	if (PCSleep = 1 and Resume = 0)
	{
		DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
	}
	else if Resume = 1
	{
		Notify("Pause Utility", "Pause repeating in 24 hours",1)
		SetTimer, TogglePause, 86400000
	}
	return
}

ToggleResume:
{
	SetTimer, ToggleResume, Off
	DetectHiddenWindows, On
	SetTitleMatchMode 2
	WinGet, ahkc_id, ID, AHKanColle ahk_class AutoHotkeyGUI
	WinGet, ahkcs_id, ID, AHKCSortie ahk_class AutoHotkeyGUI
	PostMessage, 0x111, 65306,,, ahk_id %ahkc_id%
	PostMessage, 0x111, 65306,,, ahk_id %ahkcs_id%
	SetTimer, ToggleResume, 86400000
	Notify("Pause Utility", "Resumed",1)
	return
}

#Include %A_ScriptDir%/Functions/Notify.ahk
