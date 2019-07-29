;Gunkolle v0.6.0
#Persistent
#SingleInstance
#Include %A_ScriptDir%/Functions/Gdip_All.ahk ;Thanks to tic (Tariq Porter) for his GDI+ Library => ahkscript.org/boards/viewtopic.php?t=6517

if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}
CoordMode, Pixel, Relative
Menu, Tray, Icon, %A_ScriptDir%/Icons/favicon_ahkcsortie.ico,,1

IniRead, Background, config.ini, Variables, Background, 1
IniRead, Class, config.ini, Variables, Class, 0

Initialize()

IniRead, WINID, config.ini, Variables, WINID, Nox

MiscDelay := 1000

;PixelColor Constants

#Include %A_ScriptDir%/Constants/PixelColor.ahk


BC := 0
BusyS := 0
TR := 0
DT := 0
Nodes := 1
Sortiecount := 0
StartTime := A_TickCount

IniRead, NotificationLevel, config.ini, Variables, NotificationLevel, 1
IniRead, TWinX, config.ini, Variables, LastXS, 0
IniRead, TWinY, config.ini, Variables, LastYS, 0
SpecificWindows()
IniRead, MinRandomWait, config.ini, Variables, MinRandomWaitS, 0
IniRead, MaxRandomWait, config.ini, Variables, MaxRandomWaitS, 300000
IniRead, Doll1, config.ini, Variables, Doll1, AR15
IniRead, Doll2, config.ini, Variables, Doll2, M4A1
IniRead, Doll3, config.ini, Variables, Doll3
IniRead, Doll4, config.ini, Variables, Doll4
IniRead, WeaponType, config.ini, Variables, WeaponType, AssaultRifle
IniRead, ProductionTdoll, config.ini, Variables, ProductionTdoll, 0
IniRead, ProductionEquipment, config.ini, Variables, ProductionEquipment, 0
IniRead, Enhancement, config.ini, Variables, Enhancement, 0
; IniRead, DisassembleCycle, config.ini, Variables, DisassembleCycle, 3
IniRead, FriendCollector, config.ini, Variables, FriendCollector, 0
IniRead, BatteryCollector, config.ini, Variables, BatteryCollector, 0
IniRead, CombatSimsData, config.ini, Variables, CombatSimsData, 0
IniRead, SortieInterval, config.ini, Variables, SortieInterval, -1 ;900000 for full morale
IniRead, WorldV, config.ini, Variables, WorldSwitcher 
IniRead, AutoBattleResendV, config.ini, Variables, AutoBattleResend
IniRead, AMDV, config.ini, GPU, AMD


Gui, 1: New
Gui, 1: Default
Gui, Add, Text,, Map:
Gui, Add, Text,, MinWait:
Gui, Add, Text,, MaxWait:
Gui, Add, Edit, r1 w20 vNB ReadOnly
GuiControl, Move, NB, x10 w300 y80
Gui, Add, DDL, x40 w60 ym-3 vWorldV, |0_2|3_6|5_4|5_4_friendly|5_2E|4_3E
GuiControl, ChooseString, WorldV, %WorldV%
; Gui, Add, Edit, gWorldF r2 limit3 w10 vWorldV -VScroll ym, %World%
; GuiControl, Move, WorldV, x37 h17 w15
; Gui, Add, Text, x55 ym, -
; Gui, Add, Edit, gMapF r2 limit3 w10 vMapV -VScroll ym, %Map%
; GuiControl, Move, MapV, x62 h17 w20
Gui, Add, Text, ym, Interval(ms):
Gui, Add, Edit, gIntervalF r2 w15 vIntervalV -VScroll ym, %SortieInterval%
GuiControl, Move, IntervalV, h17 w70
Gui, Add, Checkbox, vExpeditionV , Expedition only
GuiControl, Move, ExpeditionV, x150 y33
Gui, Add, Checkbox, vcorpsedragoffV , Corpse dragging off?(4_3E only)
GuiControl, Move, corpsedragoffV, x150 y58
; Gui, Add, Text, vText, #Nodes
; GuiControl, Move, Text, x150 y35
; Gui, Add, Edit, gNodeCount r2 limit3 w10 vNodeCount -VScroll ym, %Nodes%
; GuiControl, Move, NodeCount, x195 y33 h17 w25
Gui, Add, Button, gSSBF vSSB, A
GuiControl, Move, SSB, x250 w60 ym
GuiControl,,SSB, Start
Gui, Add, Edit, gMiW r2 w20 vmid -VScroll, %MinRandomWait%
GuiControl, Move, mid, h20 x60 y30 w80
Gui, Add, Edit, gMaW r2 w20 vmad -VScroll, %MaxRandomWait%
GuiControl, Move, mad, h20 x60 y55 w80
Menu, Main, Add, Pause, Pause2
Menu, Main, Add, 0, DN
Gui, Menu, Main
Gui, Show, X%TWinX% Y%TWinY% Autosize, Gunkolle v0.6.0
Gui -AlwaysOnTop
Gui +AlwaysOnTop
SetWindow()
if DisableCriticalCheck = 1
{
	GuiControl,, NB, Ready - WARNING: CRITICAL CHECK IS OFF
}
return



;TODO
; need new click function specifically for nodes

;pass in values with 'o' wait for 5-10 Seconds
;	while !found
;		if not found within 5 seconds, start from 'o parameter' count up every second until 30 seconds
;			if not found within 30 seconds, activate 'expedition search'
;	while found
;		keep clicking until !found
;	
; Random

; Or

; find img
; click img til gone.
RFindClick(x,y,v*)
{
	local RandX, RandY := v[1], radius := 5, counter := 0
	Random, OutX, -1.0, 1.0
	Random, Sign, -1.0, 1.0
	RandY += Round((sqrt(1 - OutX ** 2) * radius * Sign)) 
	RandX += Round((OutX * radius))
	GuiControl,, NB, %x%
	Found := 0
	while (Found == 0)
	{
		Found := FindClick(A_ScriptDir "\pics\" x,y " Center x"RandX " y"RandY " n0 count1")
		if(Found == 0)
		{
			FindClick(A_ScriptDir "\pics\ExpeditionArrive", "rNoxPlayer mc o50 Count1")
			FindClick(A_ScriptDir "\pics\ExpeditionConfirm", "rNoxPlayer mc o40 Count1")
		}
		else
		{
			FindClick(A_ScriptDir "\pics\" x,y "Center x"RandX " y"RandY)
			previousImg := x
			previousParameters := y
		}
		if(counter == 1)
		{
			FindClick(A_ScriptDir "\pics\" previousImg,previousParameters "Center x"RandX " y"RandY "w5000,50")
		}
		counter++
	}
	return
}

; Wait incremental
WFindClick(x,y,SearchNumber := 40)
{	
	local RandX, RandY, radius := 5
	Random, OutX, -1.0, 1.0
	Random, Sign, -1.0, 1.0
	RandY += Round((sqrt(1 - OutX ** 2) * radius * Sign)) 
	RandX += Round((OutX * radius))
	GuiControl,, NB, %x%
	Found := 0
	Found := FindClick(A_ScriptDir "\pics\" x,y " rNoxPlayer mc o"SearchNumber " dtop n0")
	while (found == 0) 
	{
		SearchNumber:= SearchNumber + 6
		Found := FindClick(A_ScriptDir "\pics\" x,y " rNoxPlayer mc o"SearchNumber " n0")
		GuiControl,, NB, pixel shade offset [%SearchNumber%]
		if (SearchNumber >= 200)
		{
			GuiControl,, NB, Could not find %x%, exit and redo config.
			Pause
			SearchNumber := 0
		}
	}
	GuiControl,, NB, pixel shade offset [%SearchNumber%]
	FindClick(A_ScriptDir "\pics\" x, y "Center x" RandX " y"  RandY " o" SearchNumber)
	previousImg := x
}

NoStopFindClick(x,y,v*)
{
	local RandX, RandY := v[1], radius := 5, looper := 1
	Random, OutX, -1.0, 1.0
	Random, Sign, -1.0, 1.0
	RandY += Round((sqrt(1 - OutX ** 2) * radius * Sign)) 
	RandX += Round((OutX * radius))
	GuiControl,, NB, %x%
	Found := FindClick(A_ScriptDir "\pics\" x,y " Center x"RandX " y"RandY " n0 count1")
	Found2:= FindClick(A_ScriptDir "\pics\ExpeditionArrive", "rNoxPlayer mc o50 Center x"RandX " y"RandY "  n0 Count1")
	loop, %looper%
	{
		if (Found == 1)
		{
			RSleep(MinRandomWait, MaxRandomWait)
			FindClick(A_ScriptDir "\pics\" x,y "Center x"RandX " y"RandY)
			return 1
		}
		if (Found2 == 1)
		{
			while(Found3 != 1)
			{
				FindClick(A_ScriptDir "\pics\ExpeditionArrive", "rNoxPlayer mc o50 Center x"RandX " y"RandY "Count1")
				Found3 := FindClick(A_ScriptDir "\pics\ExpeditionConfirm", "rNoxPlayer mc o40 Center x"RandX " y"RandY "Count1")
			}
			looper +=1
		}
	}
}

ClickTilGone(x,y,v*)
{
	local RandX, RandY := v[1], radius := 5
	Random, OutX, -1.0, 1.0
	Random, Sign, -1.0, 1.0
	RandY += Round((sqrt(1 - OutX ** 2) * radius * Sign)) 
	RandX += Round((OutX * radius))
	GuiControl,, NB, %x%
	Found := FindClick(A_ScriptDir "\pics\" x,y " count1 Center x"RandX " y"RandY)
	While (Found == 1)
	{
		FindClick(A_ScriptDir "\pics\" x,y "Center x"RandX " y"RandY " w1,1")
		Found := FindClick(A_ScriptDir "\pics\" x,y " n0 count1 w1,1")
		count += 1
		if(found != 1)
		{
			break
		}
	}
}


TFindClick(ClickThis,WaitForThis,v*)
{
	local RandX, RandY := v[1], radius := 5
	Random, OutX, -1.0, 1.0
	Random, Sign, -1.0, 1.0
	RandY += Round((sqrt(1 - OutX ** 2) * radius * Sign)) 
	RandX += Round((OutX * radius))
	Found := FindClick(A_ScriptDir "\pics\" WaitForThis, "rNoxPlayer mc o30 Count1 n0")
	GuiControl,, NB, %ClickThis%
	While (Found == 0)
	{
		FindClick(A_ScriptDir "\pics\"ClickThis, "rNoxPlayer mc o30 Center x"RandX " y"RandY)
		Found := FindClick(A_ScriptDir "\pics\" WaitForThis, " rNoxPlayer mc o30 Count1 n0 w500,50")
		GuiControl,, NB, Waiting for [%WaitForThis%]
	}
}

Transition(ClickThis,WaitForThis)
{
	Global
	local RandX, RandY, radius := 5
	local Counter
	Random, OutX, -1.0, 1.0
	Random, Sign, -1.0, 1.0
	RandY += Round((sqrt(1 - OutX ** 2) * radius * Sign)) 
	RandX += Round((OutX * radius))
	FormatTime, TimeString,% A_NowUTC, HHmm
	Found := FindClick(A_ScriptDir "\pics\" WaitForThis, "rNoxPlayer mc o40 Count1 n0")
	While (Found == 0)
	{
		FindClick(A_ScriptDir "\pics\ExpeditionArrive", "rNoxPlayer mc o50 Center x"RandX " y"RandY)
		FindClick(A_ScriptDir "\pics\ExpeditionConfirm", "rNoxPlayer mc o40 Center x"RandX " y"RandY)
		FindClick(A_ScriptDir "\pics\"ClickThis, "rNoxPlayer mc o30 Center x"RandX " y"RandY)
		Found := FindClick(A_ScriptDir "\pics\" WaitForThis, " rNoxPlayer mc o40 Count1 n0 w500,50")
		Found2:= FindClick(A_ScriptDir "\pics\MissionAccompished", "rNoxPlayer mc o40 Count1 n0")
		GuiControl,, NB, Waiting for [%WaitForThis%] | loop counter == %Counter%
		Counter++
		if ((Counter >= 20) && (Found == 0))
		{
			Counter = 0
;			ExpeditionCheck("daily")
		}
		if (Found2 == true)
		{
			FoundHome = 0
			While (FoundHome != true) 
			{
				ClickS(Expeditionx,Expeditiony)
				FoundHome := FindClick(A_ScriptDir "\pics\WaitForHome", "rNoxPlayer mc o30 w1000,50 Count1 n0 a1200,,,-600")
			}
			
		}

	}
}



UpdateEnergy()
{
	global
	FindClick(A_ScriptDir "\pics\CombatSims\Data\DataModeClicked", "rNoxPlayer mc o30 Count1 w15000,50 n0")
	EnergyCount = 0
	FoundEnergy := FindClick(A_ScriptDir "\pics\CombatSims\Data\Energy0", "rNoxPlayer mc o30 Count1 w1000,50 n0")
	While (FoundEnergy != true) {
		EnergyCount++
		FoundEnergy := FindClick(A_ScriptDir "\pics\CombatSims\Data\Energy" EnergyCount, "rNoxPlayer mc o30 Count1 n0")
	}
	GuiControl,, NB, EnergyCount == %EnergyCount% CombatSimsData == %CombatSimsData%
	return EnergyCount
}


TimeCheck()
{
	global
	; global FriendCollector
	; global FriendChecker
	; global BatteryCollector
	; global BatteryChecker
	FormatTime, TimeString, %A_NowUTC%, HHmm
	FormatTime, someday, %A_NowUTC%, ddd
	GuiControl,, NB, %TimeString%
	if (FriendCollector == 1) && (FriendChecker == 1)
	{
		if TimeString between 1100 and 1415
		{ 
			FriendChecker--
			Random, FriendTime, 3000000, 3600000
			SetTimer, FriendFlag, %Friendtime%
			RFindClick("Dorm\Dorm", "rNoxPlayer mc o30 w30000,50")
			RFindClick("Dorm\Visit", "rNoxPlayer mc o30 w30000,50")
			sleep 100
			RFindClick("Dorm\MyFriends", "rNoxPlayer mc o30 w30000,50")
			sleep 250
			RFindClick("Dorm\VisitDorm", "rNoxPlayer mc o30 w30000,50")
			RFindClick("Dorm\WaitForFriends", "rNoxPlayer mc o30 w30000,50 n0")
			FoundMessage := 0
			FoundMessage := FindClick(A_ScriptDir "\pics\Dorm\Message", "rNoxPlayer mc o30 count1 n0")
			while (FoundMessage == 0)
			{
				RFindClick("Dorm\Like", "rNoxPlayer mc o30 w30000,50")
				sleep 500
				Found := FindClick(A_ScriptDir "\pics\Dorm\Battery", "rNoxPlayer mc o30 count1 n0")
				if (Found == 1)
				{
					RFindClick("Dorm\Battery", "rNoxPlayer mc o30 w30000,50")
					RFindClick("Dorm\BatteryClose", "rNoxPlayer mc o30 w30000,50")
				}
				RFindClick("Dorm\Next", "rNoxPlayer mc o30 w30000,50")
				sleep 1000
				RFindClick("Dorm\WaitForFriends", "rNoxPlayer mc o30 w30000,50 n0")
				sleep 200
				FoundMessage := FindClick(A_ScriptDir "\pics\Dorm\Message", "rNoxPlayer mc o30 count1 n0 ")
			}
			RFindClick("Dorm\Return", "rNoxPlayer mc o30 w30000,50")
			RFindClick("Dorm\Exit", "rNoxPlayer mc o30 w30000,50")
			;ExpeditionCheck()
		}
	}
	if ((BatteryCollector == 1) && (BatteryChecker == 1))
	{
		if TimeString between 1900 and 2200
		{
			BatteryChecker--
			Random, BatteryTime, 3000000, 3600000
			SetTimer, BatteryFlag, %BatteryTime%
			Clicks(Dormx,Dormy)
			pc := [DormVisitButton]
			WaitForPixelColor(DormVisitButtonx,DormVisitButtony,pc,,,30)
			sleep 5000
			Clicks(Batteryx,Batteryy)
			pc := [HPC]
			WaitForPixelColor(Homex,Homey,pc,AndroidpopupExitx,AndroidpopupExity,30)
		}
	}
	if (((CombatSimsData >= 1) && (CombatSimsDataChecker == 1)))
	{
		if (((RegExMatch(someday, "Sun|Tue|Fri") && (TimeString >= 0800 && TimeString <= 2400)) || (RegExMatch(someday, "Mon|Wed|Sat") && (TimeString >= 0000 && TimeString <= 0800))))
		{
			CombatSimsDataChecker--
			Random, CombatSimsDataTime, 3600000,  3650000
			SetTimer, CombatSimsDataFlag, %CombatSimsDataTime%
			Transition("Combat","CombatPage")
			NoStopFindClick("CombatSims\Data\CombatSims", "rNoxPlayer mc o30 w1000,50")
			NoStopFindClick("CombatSims\Data\Training1", "rNoxPlayer mc o30 Count1 w30000,50 n0")
			Found := FindClick(A_ScriptDir "\pics\CombatSims\Data\DataModeClicked", "rNoxPlayer mc o30 Count1 n0 w2000")
			if (Found != True){
				RFindClick("CombatSims\Data\DataMode", "rNoxPlayer mc o30 w2000,50")
				}
			EnergyCount := UpdateEnergy()
			While (EnergyCount >= CombatSimsData) {
				EnergyCount := UpdateEnergy()
				loop,3 {
					if ((EnergyCount >= CombatSimsData) && (CombatSimsData == A_Index)) {
						RFindClick("CombatSims\Data\Training" A_Index, "rNoxPlayer mc o30 Count1 w5000,50")
						RFindClick("CombatSims\Data\EnterCombat", "rNoxPlayer mc o30 w5000,50")
						RFindClick("CombatSims\Data\Confirm", "rNoxPlayer mc o30 w5000,50")
						;needs a better wait here; perhaps the yellow combat loading screen
						sleep 5000 
						Found := 0
						While (Found != true) {
							ClickS(Homex,Homey)
							Found := FindClick(A_ScriptDir "\pics\CombatSims\Data\DataModeClicked", "rNoxPlayer mc o30 Count1 w2000,50 n0")
						}
						EnergyCount := UpdateEnergy()
						sleep 2000
					}
				}
			}
			GoHome()
		}
	}
}

Production()
{
	Global
	while (FindClick(A_ScriptDir "\pics\WaitForHome", "rNoxPlayer mc o30 Count1 n0 a1200,,,-600") != 1)
	{
		sleep 1000
		ClickS(Expeditionx,Expeditiony)
	}
	Found := FindClick(A_ScriptDir "\pics\Production\FactoryReady", "rNoxPlayer mc o30 n0 count1 a1000,300,,-300")
	GuiControl,, NB, Found something at production.
	if ((ProductionTdoll == 1 || ProductionEquipment == 1) && Found == 1) 
	{
		Transition("Production\FactoryReady","Production\WaitForTdollProduction")
		if (ProductionTdoll == 1)
		{
			FoundSlot1 := FindClick(A_ScriptDir "\pics\Production\TdollProductionComplete1", "rNoxPlayer mc o30 n0 count1 w2000,50")
			FoundSlot2 := FindClick(A_ScriptDir "\pics\Production\TdollProductionComplete2", "rNoxPlayer mc o30 n0 count1")
			FoundSlot3 := FindClick(A_ScriptDir "\pics\Production\TdollProductionComplete3", "rNoxPlayer mc o30 n0 count1")
			loop,3
			{
				ProductionCounter := A_Index
				if (FoundSlot%A_Index% == 1)
				{
					RFindClick("Production\TdollProductionComplete"A_Index, "rNoxPlayer mc o30 w30000,50")
					Loop
					{
						if ( FindClick(A_ScriptDir "\pics\Production\TdollProductionStart"ProductionCounter, "rNoxPlayer mc o50 n0 count1") == 1 )
						{
							break
						}
						Else
						{
							ClickS(Safex,Safey)
							sleep 500
						}
					}
					RFindClick("Production\TdollProductionStart"A_Index, "rNoxPlayer mc o50 w30000,50")
					RFindClick("Production\StartProduction", "rNoxPlayer mc o50 w30000,50")
					sleep 1000
				}
			}
		}
		RFindClick("Production\WaitForTdollProduction", "rNoxPlayer mc o50 w30000,50 n0")
		Found := FindClick(A_ScriptDir "\pics\Production\EquipmentReady", "rNoxPlayer mc o50 count1 n0 w2000,50")
		if ( Found == 1)
		{
			RFindClick("Production\EquipmentReady", "rNoxPlayer mc o50 w30000,50")
			RFindClick("Production\WaitForTdollProduction", "rNoxPlayer mc o50 w30000,50 n0")
			FoundSlot1 := FindClick(A_ScriptDir "\pics\Production\EquipmentSlotComplete1", "rNoxPlayer mc o50 n0 count1 w2000,50")
			FoundSlot2 := FindClick(A_ScriptDir "\pics\Production\EquipmentSlotComplete2", "rNoxPlayer mc o50 n0 count1")
			FoundSlot3 := FindClick(A_ScriptDir "\pics\Production\EquipmentSlotComplete3", "rNoxPlayer mc o50 n0 count1")
			loop,3
			{
				ProductionCounter := A_Index
				if (FoundSlot%A_Index% == 1)
				{
					RFindClick("Production\EquipmentSlotComplete"A_Index, "rNoxPlayer mc o50 w30000,50")
					Loop
					{
						if ( FindClick(A_ScriptDir "\pics\Production\EquipmentSlotStart"ProductionCounter, "rNoxPlayer mc o50 n0 count1") == 1 )
						{
							break
						}
						Else
						{
							ClickS(Safex,Safey)
							sleep 500
						}
					}
					if ( ProductionEquipment == 1)
					{
						RFindClick("Production\EquipmentSlotStart"A_Index, "rNoxPlayer mc o50 w30000,50")
						RFindClick("Production\StartProduction", "rNoxPlayer mc o50 w30000,50")
						sleep 1000
					}
				}
			}
		}
		sleep 1000
		RFindClick("FactoryReturn", "rNoxPlayer mc o50 w30000,50")
	}
}

Repair()
{
	Global
	while (FindClick(A_ScriptDir "\pics\WaitForHome", "rNoxPlayer mc o30 Count1 n0 a1200,,,-600") != 1)
	{
		GuiControl,, NB, An expedition is returning, retrying every 1
		sleep 1000
		ClickS(Expeditionx,Expeditiony)
	}
	Found := 0
	Found := FindClick(A_ScriptDir "\pics\Repair", "rNoxPlayer mc o50 w500,50 Count1 n0 a800,200,-200,-400")
	if ( Found >= 1)
	{
		Transition("Repair","RepairSlot")
		RFindClick("RepairSlot", "rNoxPlayer mc o50 w30000,50 a50,100,-1050,-100")
		RFindClick("RepairSlotWait", "rNoxPlayer mc o30 w30000,50 n0 a0,100,-1000,-300")
		sleep 250
		WFindClick("Damage", "rNoxPlayer mc")
		RFindClick("OK", "rNoxPlayer mc o50 w30000,50")
		RFindClick("RepairQuick", "rNoxPlayer mc o50 w30000,50")
		RFindClick("RepairOK", "rNoxPlayer mc o50 w30000,50")
		RFindClick("RepairReturnFaded", "rNoxPlayer mc o50 w30000,50 ")
		RFindClick("RepairReturn", "rNoxPlayer mc o50 w30000,50")
		; ExpeditionCheck("Daily")
	}
}


RSleep(min,max)
{
	Random, rtime, min, max
	Sleep, %rtime%
	return
}

ReplaceDPS(exhaustedDoll, loadedDoll, resetFilter:=False)
{
	Global
	WFindClick("DollList\"%exhaustedDoll% , "rNoxPlayer mc a125,125,-590,-220", 120) ;select Doll1
	if resetFilter
	{
		RFindClick("FilterYellow", "rNoxPlayer mc o20 w30000,50")
		RFindClick("FilterReset", "rNoxPlayer mc o20 w30000,50")
	}
	RFindClick("Filter", "rNoxPlayer mc o50 w30000,50") ; select filter
	if %loadedDoll% in %5Star%
	{
		RFindClick("5STAR", "rNoxPlayer mc o50 w10000,50") ;go to formation 
	}
	Else
	{
		RFindClick("4STAR", "rNoxPlayer mc o50 w10000,50") ;go to formation 
	}
	RFindClick("Filter"WeaponType, "rNoxPlayer mc o50 w30000,50")	
	RFindClick("Confirm", "rNoxPlayer mc o50 w30000,50")
	ClickTilGone("ProfileWait","rNoxPlayer mc o50 w30000,50 n0")
	WFindClick("DollList\"%loadedDoll% "Profile","rNoxPlayer mc a,130,-200,",120)
	RFindClick("WaitForFormation", "rNoxPlayer mc o50 w30000,50 n0") 
}

AddToSecondEchelon(doll, slot)
{
	Global
	RFindClick("WaitForFormation", "rNoxPlayer mc o50 w30000,50 n0") ;wait for formation
	Found := 0
	while(Found == 0)
	{
		if (slot == 1)
		{
			if (AMDV == 1) {
			random xee, 170, 250
			random yee, 280, 630
			ClickS(xee, yee)
			}
			ClickS(Role1x,Role1y)
		}
		else if (slot == 2)
		{
			ClickS(Role2x,Role1y)
		}	
		Found = FindClick(A_ScriptDir "\pics\FilterYellow", "rNoxPlayer mc o20 w30000,50 n0 count1")
	}	
	RFindClick("FilterYellow", "rNoxPlayer mc o20 w30000,50")
	RFindClick("FilterReset", "rNoxPlayer mc o20 w30000,50")
	RFindClick("Filter", "rNoxPlayer mc o20 w30000,50")
	if %doll% in %5Star%
	{
		RFindClick("5STAR", "rNoxPlayer mc o50 w10000,50") 
	}
	else
	{
		RFindClick("4STAR", "rNoxPlayer mc o50 w10000,50") 
	}
	RFindClick("Filter"WeaponType, "rNoxPlayer mc o50 w30000,50")
	RFindClick("Confirm", "rNoxPlayer mc o50 w30000,50")
	ClickTilGone("ProfileWait","rNoxPlayer mc o50 w30000,50 n0")
	WFindClick("DollList\"%doll% "Profile", "rNoxPlayer mc",120)  ; select Dollportrait1
}


Delay:
{
	IniRead, Busy, config.ini, Do Not Modify, Busy, 0

	if DT = 0
	{
		DT := 1
		Random, SR, MinRandomWait, MaxRandomWait
		QTS := A_TickCount
		QTL := SR
		SetTimer, NBUpdate, 2000
		tSS := MS2HMS(GetRemainingTime(QTS,QTL))
		Notify("AHKCSortie", "Starting sortie in " . tSS,1)
		Sleep SR
		goto Delay
	}
	else if (Busy = 0 and BusyS = 0)
	{
		{
			goto Sortie2
		}
	}
	else
	{
		if (Busy = 1 and BusyS = 0)
		{
			GuiControl,, NB, An expedition is returning, retrying every 10 seconds
			SetTimer, NBUpdate, Off
		}
		SetTimer, Delay, 10000
	}
	return
}


Sortie2:
{
	SetTimer, NBUpdate, Off
	SetTimer, Delay, Off
	BusyS := 1
	DT := 0
	TR := 0
	GuiControl, Hide, SSB
	CheckWindow()
	Notify("AHKCSortie", "Preparing to send sortie",1)
	; Notify("AHKCSortie", "Sortie started",1)
	; if SortieInterval != -1
	; {
	; 	SetTimer, Delay, %SortieInterval%
	; 	TR := 1
	; 	TCS := A_TickCount
	; }
	; NC := 1
	;expedition might return here
	if SortieInterval != -1
	{
		SetTimer, Delay, %SortieInterval%
		TR := 1
		TCS := A_TickCount
	}

	GuiControlGet, ExpeditionV
	GuiControl,, NB, %ExpeditionV%
	While (ExpeditionV == 1)
	{
		GuiControlGet, ExpeditionV
		GuiControl,, NB, ExpOnlyCheck %ExpeditionV%
		loopcount := 1
		while (loopcount != 0)
		{
			FoundHome := FindClick(A_ScriptDir "\pics\FoundHome", "rNoxPlayer mc o40 Count1 n0 w500")
			FoundExpedition := FindClick(A_ScriptDir "\pics\ExpeditionArrive", "rNoxPlayer mc o40 Count1 n0 w500")
			FoundAutoBattle := FindClick(A_ScriptDir "\pics\AutoBattle", "rNoxPlayer mc o40 Count1 n0 w500")
			FoundAndroidPop := FindClick(A_ScriptDir "\pics\AndroidPop", "rNoxPlayer mc o30 w3000,50 Count1 n0 a1200,,,-600")
			FoundLoginCollectExit := FindClick(A_ScriptDir "\pics\LoginCollectExit", "rNoxPlayer mc o40 Count1 n0")
			FoundLoginCollectNotice := FindClick(A_ScriptDir "\pics\LoginCollectNotice", "rNoxPlayer mc o40 Count1 n0")
			FoundDailyPop := FindClick(A_ScriptDir "\pics\DailyPop", "rNoxPlayer mc o40 Count1 n0")
			if (FoundHome == true)
			{
				GuiControl,, NB,At home
			}
			else if (FoundExpedition == true)
			{
				GuiControl,, NB, Expedition Found
				RFindClick("ExpeditionArrive", "rNoxPlayer mc o50 w30000,50")
				RFindClick("ExpeditionConfirm", "rNoxPlayer mc o50 w30000,50")
				loopcount++
			}
			else if (FoundAutoBattle == true)
			{
				if (AutoBattleResendV == 1)
				{
				GuiControl,, NB, AutoBattle Found
				RFindClick("AutoBattle", "rNoxPlayer mc o50 w30000,50")
				sleep 5000
				loop
				{		
					Found := FindClick(A_ScriptDir "\pics\AutoBattle", "rNoxPlayer mc o40 Count1 n0 w500")
					if Found >= 1
					{
						break
					}
					else
					{
						RFindClick("TdollObtain", "rNoxPlayer mc o50 w30000,50")
					}		
				}
				RFindClick("AutoBattle", "rNoxPlayer mc o50 w30000,50")
				RFindClick("AutoBattleResend", "rNoxPlayer mc o50 w30000,50")
				loopcount++
				}
				else if (AutoBattleResendV == 0)
				{
				GuiControl,, NB, AutoBattle Found
				RFindClick("AutoBattle", "rNoxPlayer mc o50 w30000,50")
				RFindClick("AutoBattleCancel", "rNoxPlayer mc o50 w30000,50")
				loopcount++
				}
			}
			else if (FoundAndroidPop == true)
			{
				GuiControl,, NB, Android popup Found
				RFindClick("ExitAndroid", "rNoxPlayer mc o50 w30000,50")
				loopcount++
			}
			else if (FoundLoginCollectExit == true)
			{
				GuiControl,, NB, Login Collect Found
				RFindClick("LoginCollectExit", "rNoxPlayer mc o50 w30000,50")
				loopcount++
			
			}
			else if (FoundDailyPop == true)
			{	
				GuiControl,, NB, Initial Event notice Found
				RFindClick("ExitNoticeFound", "rNoxPlayer mc o50 w30000,50")
				loopcount++
			}
			loopcount--

		}
	}

	Repair()

	TimeCheck()

	; if A_Hour between 9 and 11 ; if between 9am and 12pm 
	; { 
	; 	Loop 
	; 	{ 

	; 		GuiControl,, NB, %ExpeditionV%
	; 		GuiControl,, NB, At home [Expedition only]
	; 		ExpeditionCheck()
	; 		sleep 5000
	; 		if A_Hour not between 9 and 11
	; 		{
	; 			break
	; 		}
	; 	} 
	; } 

	; Check expedition
	GuiControlGet, corpsedragoffV
	if (corpsedragoffV != 1)
	{
		dualDPS := (Doll3 != "ERROR") and (Doll4 != "ERROR")
		if (Mod(Sortiecount, 2) == 0)
		{
			exhaustedDoll1 = Doll1
			loadedDoll1 = Doll2
			exhaustedDoll2 = Doll3
			loadedDoll2 = Doll4
		}
		else
		{
			exhaustedDoll1 = Doll2
			loadedDoll1 = Doll1
			exhaustedDoll2 = Doll4
			loadedDoll2 = Doll3
		}
		Found := 0
		Transition("Formation","WaitForFormation")
		ReplaceDPS(exhaustedDoll1, loadedDoll1)
		if (dualDPS)
		{
			sleep 500
			ReplaceDPS(exhaustedDoll2, loadedDoll2, True)
		}
		TFindClick("Echelon2","Echelon2Clicked")	
		sleep 1000
		AddToSecondEchelon(exhaustedDoll1, 1)
		if (dualDPS)
		{
			sleep 500
			AddToSecondEchelon(exhaustedDoll2, 2)
		}
		Transition("FormationReturn","WaitForHome")
		; Check expedition
	}	

	; ExpeditionCheck("Daily")

	Transition("Combat","CombatPage")

	GuiControlGet, WorldV
	RunMap(WorldV) 

	if (Mod(Sortiecount, 2) == 0) {
		IniWrite,%Doll2%,config.ini,Variables,Doll1
		IniWrite,%Doll1%,config.ini,Variables,Doll2
		IniWrite,%Doll4%,config.ini,Variables,Doll3
		IniWrite,%Doll3%,config.ini,Variables,Doll4
	}
	Else {
		IniWrite,%Doll1%,config.ini,Variables,Doll1
		IniWrite,%Doll2%,config.ini,Variables,Doll2
		IniWrite,%Doll3%,config.ini,Variables,Doll3
		IniWrite,%Doll4%,config.ini,Variables,Doll4
	}

	GuiControl,, NB, At home

	; Check expedition
	; ExpeditionCheck("Daily")
	; Found := FindClick(A_ScriptDir "\pics\Home", "rNoxPlayer mc o50 Count1 n0 w5000,50")

	Sortiecount++
	ti := BC+1
	Menu, Main, Rename, %BC%, %ti%
	BC += 1

	; check productions
	Production()

	GuiControl,, NB, Idle
	BusyS := 0
	GuiControl, Show, SSB
	if SortieInterval != -1
	{
		BP := 0
		SetTimer, NBUpdate, 2000
	}
	return	
}



WorldF:
{
	Gui, submit,nohide
	if WorldV contains `n
	{
		StringReplace, WorldV, WorldV, `n,,All
		GuiControl,, WorldV, %WorldV%
		Send, {end}
		if (WorldV=1 or WorldV=2 or WorldV=3 or WorldV=5)
		{
			World := WorldV
			GuiControl,, NB, World set
			IniWrite,%World%,config.ini,Variables,World
		}
		else
		{
			GuiControl,, NB, Unsupported world
		}
	}
	return
}

MapF:
{
	Gui, submit,nohide
	if MapV contains `n
	{
		StringReplace, MapV, MapV, `n,,All
		GuiControl,, MapV, %MapV%
		Send, {end}
		if (MapV=1 or MapV=2 or MapV=3 or MapV=4 or MapV=5)
		{
			Map := MapV
			GuiControl,, NB, Map # set
			IniWrite,%Map%,config.ini,Variables,Map
		}
		else
		{
			GuiControl,, NB, Unsupported map #
		}
	}
	return
}

NodeCount:
{
	Gui, submit,nohide
	if NodeCount contains `n
	{
		StringReplace, NodeCount, NodeCount, `n,,All
		GuiControl,, NodeCount, %NodeCount%
		Send, {end}
		if (NodeCount > 0 and NodeCount < 5)
		{
			Nodes := NodeCount
			GuiControl,, NB, # of nodes set
		}
		else
		{
			GuiControl,, NB, Invalid entry, must be within 1 and 3
		}
	}
	return
}

IntervalF:
{
	Gui, submit,nohide
	if IntervalV contains `n
	{
		StringReplace, IntervalV, IntervalV, `n,,All
		GuiControl,, IntervalV, %IntervalV%
		Send, {end}
		if IntervalV is integer
		{
			SortieInterval := IntervalV
			if (SortieInterval < 1000)
			{
				SortieInterval := -1
				GuiControl,, NB, Interval disabled
				SetTimer, Delay, Off
				SetTimer, NBUpdate, Off
				TR := 0
			}
			else
			{
				if TR = 1
				{
					tt := SortieInterval - A_TickCount + TCS
					if tt < 0
					{
						tt := 1000
					}
					SetTimer, Delay, %tt%
				}
				GuiControl,, NB, Interval set
			}
			IniWrite,%SortieInterval%,config.ini,Variables,SortieInterval

		}
		else
		{
			GuiControl,, NB, Invalid interval
		}
	}
	return
}

MiW:
{
	Gui, submit,nohide
	if mid contains `n
	{
		StringReplace, mid, mid, `n,,All
		GuiControl,, mid, %mid%
		Send, {end}
		MinRandomWait := mid
		IniWrite,%mid%,config.ini,Variables,MinRandomWaitS
		GuiControl,, NB, Changed minimum random delay
	}
	return
}

MaW:
{
	Gui, submit,nohide
	if mad contains `n
	{
		StringReplace, mad, mad, `n,,All
		GuiControl,, mad, %mad%
		Send, {end}
		MaxRandomWait := mad
		IniWrite,%mad%,config.ini,Variables,MaxRandomWaitS
		GuiControl,, NB, Changed max random delay
	}
	return
}

SSBF:
{
	GuiControlGet, WorldV
	IniWrite, %WorldV%, config.ini, Variables, WorldSwitcher 
	GuiControl, Hide, SSB
	BP := 1
	DT := 1
	goto Delay
	return
}

NBUpdate:
{
	if DT = 0
	{
		ts := Round((TCS + SortieInterval - A_TickCount)/60000,2)
		GuiControl,, NB, Idle - Restarting in %ts% minutes
	}
	else
	{
		tSS := MS2HMS(GetRemainingTime(QTS,QTL))
		; GuiControl,, NB, Delay - %tSS%
	}
	return
}

DN:
{
	DeltaT := A_TickCount - StartTime 
	ElapsedHours := SubStr(0 Floor(DeltaT / 3600000), -1)
	ElapsedMinutes := SubStr(0 Floor((DeltaT - ElapsedHours * 3600000) / 60000), -1)
	ElapsedSeconds := SubStr(0 Floor((DeltaT - ElapsedHours * 3600000 - ElapsedMinutes * 60000) / 1000), -1)
	SPH := (Sortiecount / (DeltaT/3600000))
	GuiControl,, NB,% "total time == "ElapsedHours ":" ElapsedMinutes ":" ElapsedSeconds " || SPH == " SPH
	return
}

FactoryFlag:
{
	FactoryFlag := 1
	FactoryChecker := 1
	return
}

FriendFlag:
{
	FriendChecker := 1
	SetTimer, FriendFlag, off
	return
}

BatteryFlag:
{
	BatteryChecker := 1
	SetTimer, BatteryFlag, off
	return
}

CombatSimsDataFlag:
{
	CombatSimsDataChecker := 1
	SetTimer, CombatSimsDataFlag, off
	return
}


#Include %A_ScriptDir%/Functions/Click.ahk
#Include %A_ScriptDir%/Functions/TimerUtils.ahk
#Include %A_ScriptDir%/Functions/PixelCheck.ahk
#Include %A_ScriptDir%/Functions/Pause.ahk
#Include %A_ScriptDir%/Functions/Window.ahk
#Include %A_ScriptDir%/Functions/PixelSearch.ahk
#Include %A_ScriptDir%/Functions/PixelMap.ahk
#Include %A_ScriptDir%/Functions/Notify.ahk
#Include %A_ScriptDir%/Functions/FindClick.ahk
#Include %A_ScriptDir%/Constants/Maps.ahk
#Include %A_ScriptDir%/Constants/Retirement.ahk
#Include %A_ScriptDir%/Functions/Mouse.ahk



Initialize()
{
    global
	SPGx := Array(item)
	MAPx := Array(item)
	MAPy := Array(item)
	ShipHealthy := Array(item)
	pc := Array(item)
    Q := Array()
	NC := 0
	ClickDelay := 50
	coffset := 10
	FactoryChecker := 1
	FactoryFlag := 1
	FriendChecker := 1
	BatteryChecker := 1
	CombatSimsDataChecker := 1
	5Star = TYPE97,OTS14,HK416,G41,TYPE95,G11,FAL,WA2000
	4Star = 
	init_mouse()
}

GuiClose:
{
	WinGetPos,TWinX,TWinY
	IniWrite,%TWinX%,config.ini,Variables,LastXS
	IniWrite,%TWinY%,config.ini,Variables,LastYS
	ExitApp
}


; TODO

; i've noticed that rarely
; it will get stuck going to formation
; if an expedition comes back
;add wait timer to retirement 3 stars

