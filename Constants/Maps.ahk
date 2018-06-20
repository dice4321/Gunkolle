
RunMap(x)
{
	if (x == "4_3E")
	{
		4_3E()
	}
	else if(x == "3_2N")
	{
		3_2N()
	}
}


4_3E( )
{
	Global
	RFindClick("Emergency", "rNoxPlayer mc o5 w30000,50")
	RFindClick("4_3e", "rNoxPlayer mc o5 w30000,50")
	RFindClick("battle", "rNoxPlayer mc o5 w30000,50")
	Sleep 3000
	Found := FindClick(A_ScriptDir "\pics\Heliport", "rNoxPlayer mc o5 Count1 n0 w5000,50")
	if Found >= 1
	{

	}
	Else
	{
		GuiControl,, NB, Paused
		Pause
	}
	RFindClick("Heliport", "rNoxPlayer mc o5 w30000,50")
	RFindClick("Battleok", "rNoxPlayer mc o5 w30000,50")
	RFindClick("CommandPost", "rNoxPlayer mc o5 w30000,50")
	RFindClick("Battleok", "rNoxPlayer mc o5 w30000,50")
	RFindClick("StartCombat", "rNoxPlayer mc o5 w30000,50")
	Sleep 4000
	if (corpsedragoffV != 1)
	{
		RFindClick("4_3eCommandPostResupply", "rNoxPlayer mc o5 w30000,50 n2 sleep1000")
		RFindClick("ResupplyButton", "rNoxPlayer mc o5 w30000,50")
		sleep 1000
		RFindClick("4_3eHeliResupply", "rNoxPlayer mc o5 w30000,50")
		sleep 1000
	}
	if (corpsedragoffV == 1)
	{
		RFindClick("4_3eHeliResupply", "rNoxPlayer mc o5 w30000,50 n2 sleep 1000")
		RFindClick("ResupplyButton", "rNoxPlayer mc o5 w30000,50")

	}
	sleep 1000
	RFindClick("Planning", "rNoxPlayer mc o5 w30000,50")
	RFindClick("4_3eEnemy1", "rNoxPlayer mc o30 w30000,50")
	RFindClick("4_3eEnemy2", "rNoxPlayer mc o15 w30000,50")
	sleep 500
	ControlSend, , a, Nox
	sleep 1000
	RFindClick("4_3eEnemy3", "rNoxPlayer mc o10 w30000,50")
	RFindClick("4_3eEnemy4", "rNoxPlayer mc o25 w30000,50")
	sleep 1000
	RFindClick("execute", "rNoxPlayer mc o5 w30000,50")

	loop, 4
	{
		Found := 0
		FindClick(A_ScriptDir "\pics\CombatPause", "rNoxPlayer mc o5 Count1 n0 w30000,50")
		while(Found == 0)
		{
			Found := 0
			Found := FindClick(A_ScriptDir "\pics\EndTurn", "rNoxPlayer mc o15 Count1 n0")
			if Found >= 1
			{

			}
			else
			{
				ClickS(Safex,Safey)
				sleep 200
			}
			GuiControl,, NB, %found%
		}
	}
	RFindClick("EndTurn", "rNoxPlayer mc o5 w30000,50")

	; go home
	;needs fixing, find image before home screen to stop
	loopcount := 1
	loop, %loopcount%
	{
		Found := 0
		FoundAlt := 0
		sleep 5000
		while(Found == 0 && FoundAlt == 0)
		{
			Found := FindClick(A_ScriptDir "\pics\Home", "rNoxPlayer mc o5 Count1 n0")
			FoundAlt := FindClick(A_ScriptDir "\pics\DailyMessage", "rNoxPlayer mc o5 Count1 n0")
			if (Found >= 1 or FoundAlt >= 1)
			{

			}
			else
			{
				Found2 :=0
				Found2 := FindClick(A_ScriptDir "\pics\ExpeditionConfirm", "rNoxPlayer mc o5 Count1 n0")
				if Found2 >= 1
				{
					loopcount++
				}
				ClickS(Expeditionx,Expeditiony)
				sleep 200
			}
			GuiControl,, NB, %found% %FoundAlt%
		}
	}
}

3_2N( )
{
	Global
	RFindClick("\Maps\3_2N\NightBattle", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\3_2N\WaitFor3_2N", "rNoxPlayer mc o5 w30000,50 n0")
	sleep 1000
	RFindClick("\Maps\3_2N\3_2N", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\3_2N\Battle", "rNoxPlayer mc o5 w30000,50")
	Found := FindClick(A_ScriptDir "\pics\Maps\3_2N\WaitMap", "rNoxPlayer mc o10 Count1 n0 w30000,50")
	if Found >= 1
	{

	}
	Else
	{
		GuiControl,, NB, Paused
		Pause
	}
	RFindClick("\Maps\3_2N\WaitMap", "rNoxPlayer mc o10 w30000,50 n0")
	RFindClick("\Maps\3_2N\HeliPort1", "rNoxPlayer mc o10 w30000,50 a199,200,-980,-440")
	RFindClick("\Maps\3_2N\HeliPortOK", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\3_2N\HeliPort2", "rNoxPlayer mc o10 w30000,50")
	RFindClick("\Maps\3_2N\HeliPortOK", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\3_2N\StartCombat", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\3_2N\CloseNight", "rNoxPlayer mc o5 w30000,50")
	sleep 3000
	RFindClick("\Maps\3_2N\HeliPort2After", "rNoxPlayer mc o25 w30000,50 n2 a270,550,-920,-100")
	RFindClick("\Maps\3_2N\HeliPort2Supply", "rNoxPlayer mc o5 w30000,50")
	sleep 2000
	RFindClick("\Maps\3_2N\HeliPort2After", "rNoxPlayer mc o20 w2000,50 a270,550,-920,-100")
	RFindClick("\Maps\3_2N\Retreat", "rNoxPlayer mc o5 w2000,50 ")
	sleep 500
	RFindClick("\Maps\3_2N\Confirm", "rNoxPlayer mc o5 w30000,50")
	sleep 1000
	RFindClick("\Maps\3_2N\PlanningMode", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\3_2N\HeliPort1After", "rNoxPlayer mc o40 w30000,50 a199,200,-980,-440")
	RFindClick("\Maps\3_2N\3_2NEnemy1", "rNoxPlayer mc o20 w30000,50")
	RFindClick("\Maps\3_2N\3_2NEnemy2", "rNoxPlayer mc o20 w30000,50")
	RFindClick("\Maps\3_2N\3_2NEnemy3", "rNoxPlayer mc o20 w30000,50")
	RFindClick("\Maps\3_2N\Execute", "rNoxPlayer mc o5 w30000,50")

	loop, 3
	{
		Found := 0
		FindClick(A_ScriptDir "\pics\CombatPause", "rNoxPlayer mc o5 Count1 n0 w30000,50")
		while(Found == 0)
		{
			Found := 0
			Found := FindClick(A_ScriptDir "\pics\EndTurn", "rNoxPlayer mc o15 Count1 n0")
			if Found >= 1
			{

			}
			else
			{
				ClickS(Safex,Safey)
				sleep 200
			}
			GuiControl,, NB, %found%
		}
	}
	RFindClick("\Maps\3_2N\HeliPort2After", "rNoxPlayer mc o20 w30000,50")
	RFindClick("\Maps\3_2N\Echelon3", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\3_2N\HeliPortOK", "rNoxPlayer mc o5 w30000,50")
	Sleep 3000
	RFindClick("\Maps\3_2N\HeliPort2Stage3", "rNoxPlayer mc o20 w2000,50 a270,550,-920,-100 ")
	RFindClick("\Maps\3_2N\Switcher", "rNoxPlayer mc o30 w2000,50 a520,514,-650,-170 ")
	sleep 500
	RFindClick("\Maps\3_2N\Switch", "rNoxPlayer mc o30 w2000,50")
	Sleep 1000
	RFindClick("\Maps\3_2N\WaitForSwitch", "rNoxPlayer mc o30 w30000,50 ")
	sleep 2000
	RFindClick("\Maps\3_2N\HeliPort2Stage3", "rNoxPlayer mc o20 w30000,50 a270,550,-920,-100 ")
	RFindClick("\Maps\3_2N\Select", "rNoxPlayer mc o20 w30000,50 ")
	RFindClick("\Maps\3_2N\Helipad2Select", "rNoxPlayer mc o20 w30000,50 a270,550,-920,-100")
	RFindClick("\Maps\3_2N\Retreat", "rNoxPlayer mc o5 w2000,50 ")
	sleep 500
	RFindClick("\Maps\3_2N\Confirm", "rNoxPlayer mc o5 w30000,50")
	sleep 1000
	RFindClick("\Maps\3_2N\Terminate", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\3_2N\TerminateOK", "rNoxPlayer mc o5 w30000,50")

	; go home
	;needs fixing, find image before home screen to stop
	loopcount := 1
	loop, %loopcount%
	{
		Found := 0
		FoundAlt := 0
		sleep 5000
		while(Found == 0 && FoundAlt == 0)
		{
			Found := FindClick(A_ScriptDir "\pics\Home", "rNoxPlayer mc o5 Count1 n0")
			FoundAlt := FindClick(A_ScriptDir "\pics\DailyMessage", "rNoxPlayer mc o40 Count1 n0")
			if (Found >= 1 or FoundAlt >= 1)
			{

			}
			else
			{
				Found2 :=0
				Found2 := FindClick(A_ScriptDir "\pics\ExpeditionConfirm", "rNoxPlayer mc o5 Count1 n0")
				if Found2 >= 1
				{
					loopcount++
				}
				ClickS(Expeditionx,Expeditiony)
				sleep 200
			}
			GuiControl,, NB, %found%
		}
	}
RetirementCounter--
}