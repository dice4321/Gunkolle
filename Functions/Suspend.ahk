;Suspend v1.0

SysIntSuspend(sus)
{
	if sus = 1
	{
		Run %A_ScriptDir%\Sysinternals\pssuspend.exe KanColleViewer.exe
	}else
	{
		Run %A_ScriptDir%\Sysinternals\pssuspend.exe -r KanColleViewer.exe
	}
}