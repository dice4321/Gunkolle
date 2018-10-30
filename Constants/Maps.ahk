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
	else if(x == "5_4")
	{
		5_4()
	}
	else if(x == "0_2")
	{
		0_2()
	}
	else if(x == "5_2E")
	{
		5_2E()
	}
}

nodes(nodecount)
{
	Global
	loop, %nodecount%
	{
		Found := 0
		RFindClick("CombatPause", "rNoxPlayer mc o5 Count1 n0 w30000,50")
		while(Found == 0)
		{
			Found := 0
			Found := RFindClick("LoadScreen", "rNoxPlayer mc o50 n0 Count1 w100,50")
			if Found >= 1
			{

			}
			else
			{
				ClickS(Safex,Safey)
			}
			GuiControl,, NB, %found%
		}
		RFindClick("EndTurn", "rNoxPlayer mc o50 Count1 n0 w30000,50")
	}
}

GoHome()
{
	Global
	loopcount := 1
	loop, %loopcount%
	{
		Found1 := 0
		Found2 := 0
		Found3 := 0
		sleep 5000
		while(Found1 == 0 && Found2 == 0)
		{
			Found1 := RFindClick("Home", "rNoxPlayer mc o5 Count1 n0")
			Found2 := RFindClick("DailyMessage", "rNoxPlayer mc o40 Count1 n0")
			if (Found1 >= 1 or Found2 >= 1)
			{

			}
			else
			{
				Found3 := RFindClick("CombatReturn", "rNoxPlayer mc o40 Count1 w100,50")
				FoundExp := RFindClick("ExpeditionConfirm", "rNoxPlayer mc o5 Count1")
				if FoundExp >= 1
				{
					loopcount++
				}
				ClickS(Homex,Homey)
			}
			GuiControl,, NB, %found1% %found2% %found3% 
		}
	}
}

5_2E()
{
	Global
	RFindClick("Emergency", "rNoxPlayer mc o5 w30000,50")
	sleep 250
	RFindClick("\Maps\5_2E\5_2E", "rNoxPlayer mc o5 w30000,50")
	RFindClick("battle", "rNoxPlayer mc o5 w30000,50")	
	sleep 3000
	Found := RFindClick("Maps\5_2E\HeliportBottomLeft", "rNoxPlayer mc o5 Count1 n0 w5000,50")
	if Found >= 1
	{

	}
	Else
	{
		GuiControl,, NB, Paused
		Pause
	}
	RFindClick("\Maps\5_2E\HeliportBottomLeft", "rNoxPlayer mc o5 w30000,50")
	RFindClick("Battleok", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\5_2E\CommandPost", "rNoxPlayer mc o5 w30000,50")
	RFindClick("Battleok", "rNoxPlayer mc o5 w30000,50")
	RFindClick("StartCombat", "rNoxPlayer mc o30 w3000,10 a1000,620")
	sleep 4000
	RFindClick("\Maps\5_2E\CommandPost", "rNoxPlayer mc o5 w30000,50 n2 sleep1000")
	RFindClick("ResupplyButton", "rNoxPlayer mc o5 w30000,50")
	sleep 1000
	RFindClick("Planning", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\5_2E\HeliportBottomLeftPlanning", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\5_2E\Enemy1", "rNoxPlayer mc o30 w30000,50")
	RFindClick("\Maps\5_2E\Enemy2", "rNoxPlayer mc o30 w30000,50")
	RFindClick("\Maps\5_2E\Enemy3", "rNoxPlayer mc o30 w30000,50")
	RFindClick("\Maps\5_2E\Enemy4", "rNoxPlayer mc o30 w30000,50")
	RFindClick("\Maps\5_2E\Enemy5", "rNoxPlayer mc o30 w30000,50")
	RFindClick("Execute", "rNoxPlayer mc o5 w30000,50")
	nodes(5)
	sleep 1000
	RFindClick("EndTurn", "rNoxPlayer mc o30 w30000,50 a1100,620")
	GoHome()
}


4_3E( )
{
	Global
	RFindClick("Emergency", "rNoxPlayer mc o5 w30000,50")
	sleep 250
	RFindClick("4_3e", "rNoxPlayer mc o5 w30000,50")
	RFindClick("battle", "rNoxPlayer mc o5 w30000,50")
	Sleep 3000
	Found := RFindClick("Heliport", "rNoxPlayer mc o5 Count1 n0 w5000,50")
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
	RFindClick("StartCombat", "rNoxPlayer mc o30 w3000,10 a1000,620")
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
	RFindClick("Execute", "rNoxPlayer mc o5 w30000,50")

	nodes(4)
	
	RFindClick("EndTurn", "rNoxPlayer mc o30 w30000,50 a1100,620")

	; go home
	GoHome()
}

3_2N( )
{
	Global
	RFindClick("\Maps\3_2N\NightBattle", "rNoxPlayer mc o30 w30000,50")
	sleep 250
	RFindClick("\Maps\3_2N\3_2N", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\3_2N\Battle", "rNoxPlayer mc o5 w30000,50")
	Found := RFindClick("Maps\3_2N\WaitMap", "rNoxPlayer mc o30 Count1 n0 w30000,50")
	if Found >= 1
	{

	}
	Else
	{
		GuiControl,, NB, Paused
		Pause
	}
	RFindClick("\Maps\3_2N\WaitMap", "rNoxPlayer mc o30 w30000,50 n0")
	RFindClick("\Maps\3_2N\HeliPort1", "rNoxPlayer mc o30 w30000,50 a199,200,-980,-440")
	RFindClick("\Maps\3_2N\HeliPortOK", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\3_2N\HeliPort2", "rNoxPlayer mc o30 w30000,50")
	RFindClick("\Maps\3_2N\HeliPortOK", "rNoxPlayer mc o5 w30000,50")
	RFindClick("StartCombat", "rNoxPlayer mc o30 w3000,10 a1000,620")
	RFindClick("\Maps\3_2N\CloseNight", "rNoxPlayer mc o5 w30000,50")
	sleep 2000
	RFindClick("\Maps\3_2N\HeliPort2After", "rNoxPlayer mc o30 w30000,10 n2 a270,550,-920,-100")
	sleep 500
	RFindClick("\Maps\3_2N\HeliPort2Supply", "rNoxPlayer mc o5 w30000,50")
	sleep 500
	RFindClick("\Maps\3_2N\HeliPort2AfterClicked", "rNoxPlayer mc o30 w30000,50 a270,550,-920,-100")
	RFindClick("\Maps\3_2N\Retreat", "rNoxPlayer mc o5 w12000,50 ")
	sleep 500
	RFindClick("\Maps\3_2N\Confirm", "rNoxPlayer mc o5 w30000,50")
	sleep 1000
	RFindClick("\Maps\3_2N\PlanningMode", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\3_2N\HeliPort1After", "rNoxPlayer mc o40 w30000,50 a199,200,-980,-440")
	RFindClick("\Maps\3_2N\3_2NEnemy1", "rNoxPlayer mc o30 w30000,50")
	RFindClick("\Maps\3_2N\3_2NEnemy2", "rNoxPlayer mc o30 w30000,50")
	RFindClick("\Maps\3_2N\3_2NEnemy3", "rNoxPlayer mc o30 w30000,50")
	RFindClick("Execute", "rNoxPlayer mc o5 w30000,50")

	nodes(3)

	RFindClick("\Maps\3_2N\HeliPort2After", "rNoxPlayer mc o30 w30000,10 a270,550,-920,-100")
	sleep 500
	RFindClick("\Maps\3_2N\Echelon3", "rNoxPlayer mc o60 w30000,50")
	RFindClick("\Maps\3_2N\HeliPortOK", "rNoxPlayer mc o5 w30000,50")
	Sleep 2000
	RFindClick("\Maps\3_2N\HeliPort2Stage3", "rNoxPlayer mc o30 w2000,50 a270,550,-920,-100 ")
	RFindClick("\Maps\3_2N\Switcher", "rNoxPlayer mc o30 w2000,50 a520,514,-650,-170 ")
	sleep 500
	RFindClick("\Maps\3_2N\Switch", "rNoxPlayer mc o30 w2000,50")
	Sleep 1000
	RFindClick("\Maps\3_2N\WaitForSwitch", "rNoxPlayer mc o30 w30000,50 n0")
	sleep 2000
	RFindClick("\Maps\3_2N\HeliPort2Stage3", "rNoxPlayer mc o30 w30000,50 a270,550,-920,-100 ")
	RFindClick("\Maps\3_2N\Select", "rNoxPlayer mc o30 w30000,50 ")
	RFindClick("\Maps\3_2N\Helipad2Select", "rNoxPlayer mc o30 w30000,50 a270,550,-920,-100")
	RFindClick("\Maps\3_2N\Retreat", "rNoxPlayer mc o5 w2000,50 ")
	sleep 500
	RFindClick("\Maps\3_2N\Confirm", "rNoxPlayer mc o30 w30000,50")
	sleep 1000
	RFindClick("\Maps\3_2N\Terminate", "rNoxPlayer mc o30 w30000,50")
	RFindClick("\Maps\3_2N\TerminateOK", "rNoxPlayer mc o30 w30000,50")

	GoHome()
	RetirementCounter--
}

5_4()
{
	Global
	RFindClick("\Maps\5_4\5_4Map", "rNoxPlayer mc o5 w30000,50")
	RFindClick("\Maps\5_4\Battle", "rNoxPlayer mc o5 w30000,50")
	Found := RFindClick("Maps\5_4\5_4MapWait", "rNoxPlayer mc o10 Count1 n0 w30000,50")
	if Found >= 1
	{

	}
	Else
	{
		GuiControl,, NB, Paused
		Pause
	}
	RFindClick("\Maps\5_4\5_4MapWait", "rNoxPlayer mc o10 w30000,50 n0")
	RFindClick("\Maps\5_4\TopLeftHeliPort", "rNoxPlayer mc o10 w30000,50")
	RFindClick("\Maps\5_4\OK", "rNoxPlayer mc o10 w30000,50")
	RFindClick("\Maps\5_4\CommandCenter", "rNoxPlayer mc o10 w30000,50 Center a950,,,-500")
	RFindClick("\Maps\5_4\OK", "rNoxPlayer mc o10 w30000,50")
	RFindClick("StartCombat", "rNoxPlayer mc o30 w3000,10 a1000,620")
	sleep 1000
	RFindClick("\Maps\5_4\5_4MapWait", "rNoxPlayer mc o10 w30000,50 n0")
	sleep 2000
	RFindClick("\Maps\5_4\CommandCenterAfter", "rNoxPlayer mc o10 a950,,,-500 w2000,50 n6 sleep100")
	RFindClick("\Maps\5_4\Resupply", "rNoxPlayer mc o10 w30000,50")
	sleep 500
	RFindClick("\Maps\5_4\TopLeftHeliPort", "rNoxPlayer mc o10 w30000,50")
	RFindClick("\Maps\5_4\PlanningMode", "rNoxPlayer mc o10 w30000,50")
	RFindClick("\Maps\5_4\5_4Enemy1", "rNoxPlayer mc o10 w30000,50")
	RFindClick("\Maps\5_4\5_4Enemy2", "rNoxPlayer mc o10 w30000,50")
	RFindClick("\Maps\5_4\5_4Enemy3", "rNoxPlayer mc o10 w30000,50")
	RFindClick("\Maps\5_4\5_4Enemy4", "rNoxPlayer mc o10 w30000,50")
	RFindClick("\Maps\5_4\5_4Enemy5", "rNoxPlayer mc o10 w30000,50")
	RFindClick("Execute", "rNoxPlayer mc o5 w30000,50")

	nodes(5)

	RFindClick("EndTurn", "rNoxPlayer mc o30 w30000,50 a1100,620")

	GoHome()
}

0_2()
{
	Global
	RFindClick("\Maps\0_2\0_2Map", "rNoxPlayer mc o10 w30000,50")
	RFindClick("\Maps\0_2\0_2Battle", "rNoxPlayer mc o10 w30000,50")
	Found := RFindClick("Maps\0_2\0_2MapWait", "rNoxPlayer mc o30 Count1 n0 w30000,50")
	if Found >= 1
	{

	}
	Else
	{
		GuiControl,, NB, Cound not find map reference, Paused
		Pause
	}
	RFindClick("\Maps\0_2\0_2CommandPost", "rNoxPlayer mc o10 w30000,50 ")
	RFindClick("\Maps\0_2\OK", "rNoxPlayer mc o10 w30000,50 ")
	RFindClick("\Maps\0_2\HeliPort", "rNoxPlayer mc o10 w30000,50 ")
	RFindClick("\Maps\0_2\OK", "rNoxPlayer mc o10 w30000,50 ")
	RFindClick("StartCombat", "rNoxPlayer mc o30 w3000,10 a1000,620")
	sleep 1000
	RFindClick("Maps\0_2\0_2MapWait", "rNoxPlayer mc o30 Count1 n0 w30000,50")
	sleep 1000
	RFindClick("\Maps\0_2\HeliPortResupply", "rNoxPlayer mc o20 w30000,50")
	RFindClick("\Maps\0_2\HeliPortResupply2", "rNoxPlayer mc o20 w30000,50")
	RFindClick("\Maps\0_2\Resupply", " rNoxPlayer mc o10 w30000,50")
	sleep 500
	RFindClick("\Maps\0_2\CommandCenterResupply", "rNoxPlayer mc o10 a550,300,-550,-300 w1000,50 ")
	RFindClick("\Maps\0_2\PlanningMode", "rNoxPlayer mc o10 w30000,50 ")
	RFindClick("\Maps\0_2\0_2Enemy1", "rNoxPlayer mc o30 w30000,50 ")
	sleep 500
	ControlSend, , a, Nox
	sleep 1000
	RFindClick("\Maps\0_2\0_2Enemy2", "rNoxPlayer mc o30 w30000,50 ")
	RFindClick("\Maps\0_2\0_2Enemy3", "rNoxPlayer mc o30 w30000,50 ")
	RFindClick("\Maps\0_2\0_2Enemy4", "rNoxPlayer mc o30 w30000,50 ")
	RFindClick("Execute", "rNoxPlayer mc o5 w30000,50")

	nodes(3)

	RFindClick("EndTurn", "rNoxPlayer mc o30 w30000,50 a1100,620")
	sleep 5000
	Found := RFindClick("Maps\0_2\DragSquadClicked", "rNoxPlayer mc o10 Count1 n0")
	While (Found != 1)
	{
		RFindClick("\Maps\0_2\DragSquad", "rNoxPlayer mc o10 w1000,50 ")
		Found := RFindClick("Maps\0_2\DragSquadClicked", " rNoxPlayer mc o10 Count1 n0 w1000,50")
	}
	RFindClick("\Maps\0_2\PlanningMode", "rNoxPlayer mc o10 w30000,50 ")
	RFindClick("\Maps\0_2\0_2Enemy5", "rNoxPlayer mc o10 w30000,50 ")
	RFindClick("\Maps\0_2\0_2Enemy6", "rNoxPlayer mc o10 w30000,50 ")
	RFindClick("Execute", "rNoxPlayer mc o5 w30000,50")

	nodes(2)

	RFindClick("EndTurn", "rNoxPlayer mc o30 w30000,50 a1100,620")
	
	GoHome()
}



