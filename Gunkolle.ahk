;Gunkolle v0.4.6.0

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
#Include %A_ScriptDir%/Constants/Maps.ahk


BC := 0
BusyS := 0
TR := 0
DT := 0
Nodes := 1
Sortiecount := 0

IniRead, NotificationLevel, config.ini, Variables, NotificationLevel, 1
IniRead, TWinX, config.ini, Variables, LastXS, 0
IniRead, TWinY, config.ini, Variables, LastYS, 0
SpecificWindows()
IniRead, MinRandomWait, config.ini, Variables, MinRandomWaitS, 0
IniRead, MaxRandomWait, config.ini, Variables, MaxRandomWaitS, 300000
IniRead, Doll1, config.ini, Variables, Doll1, AR15
IniRead, Doll2, config.ini, Variables, Doll2, M4A1
IniRead, WeaponType, config.ini, Variables, WeaponType, AssaultRifle
IniRead, ProductionTdoll, config.ini, Variables, ProductionTdoll, 0
IniRead, ProductionEquipment, config.ini, Variables, ProductionEquipment, 0
IniRead, Enchancement, config.ini, Variables, Enchancement, 0
IniRead, DisassembleCycle, config.ini, Variables, DisassembleCycle, 3
IniRead, FriendCollector, config.ini, Variables, FriendCollector, 0
Gui, 1: New
Gui, 1: Default
Gui, Add, Text,, Map:
Gui, Add, Text,, MinWait:
Gui, Add, Text,, MaxWait:
Gui, Add, Edit, r1 w20 vNB ReadOnly
GuiControl, Move, NB, x10 w300 y80
Gui, Add, DDL, x40 w60 vWorldV -VScroll ym-3, 4_3E||3_2N|5_4|0_2 ; upcoming map changer
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
Gui, Show, X%TWinX% Y%TWinY% Autosize, Gunkolle v0.4.6.0
Gui -AlwaysOnTop
Gui +AlwaysOnTop
SetWindow()
if DisableCriticalCheck = 1
{
	GuiControl,, NB, Ready - WARNING: CRITICAL CHECK IS OFF
}
return

; node(image,loops,delay)
; {
; 	loop, %loops%
; 	{
; 		Found := 0
; 		sleep %delay%
; 		while(Found == 0)
; 		{
; 			Found := 0
; 			Found := FindClick(A_ScriptDir "\pics\"image, "rNoxPlayer mc o5 Count1 n0")
; 			if Found >= 1
; 			{

; 			}
; 			else
; 			{
; 				ClickS(Safex,Safey)
; 				sleep 200
; 			}
; 			GuiControl,, NB, %found%
; 		}
; 	}
; 	RFindClick("EndTurn", "rNoxPlayer mc o5 w30000,50")
; 	return
; }

; Random
RFindClick(x,y)
{
	local RandX, RandY
	Random, RandX, -10, 10
	Random, RandY, -10, 10
	GuiControl,, NB, %x%
	RSleep(200)
	FindClick(A_ScriptDir "\pics\" x,y "Center x"RandX " y"RandY)
			; looper++
			; loop, %looper%
			; FinderAlt = same Pic
			; if same Pic{
			; 	click same Pic
			; 	looper++
			; }
	return
}

; Wait
WFindClick(x,y)
{	
	local RandX, RandY
	Random, RandX, -10, 10
	Random, RandY, -10, 10
	GuiControl,, NB, %x%
	Found := 0
	SearchNumber := 0
	Found := FindClick(A_ScriptDir "\pics\" x,y " rNoxPlayer mc o"SearchNumber " dtop n0")
	while (found == 0) 
	{
		SearchNumber:= SearchNumber + 6
		Found := FindClick(A_ScriptDir "\pics\" x,y " rNoxPlayer mc o"SearchNumber " dtop n0")
		GuiControl,, NB, pixel shade offset [%SearchNumber%]
	}
	GuiControl,, NB, pixel shade offset [%SearchNumber%]
	FindClick(A_ScriptDir "\pics\" x, y "Center x" RandX " y"  RandY " o" SearchNumber)
}

ExpeditionCheck()
{		
	global
	loopcount := 1
	while (loopcount != 0)
	{
		; FindClick(A_ScriptDir "\pics\Home", "rNoxPlayer mc o5 Count1 n0 w3000,50")
		pc := [HPC]
		tpc := WaitForPixelColor(Homex,Homey,pc,,,5)
		tpc := 0
		sleep 3000
		pc := []
		pc := [HPC,ExpeditionReceived1,ExpeditionReceived2,Androidpopup0,Androidpopup1,LoginCollect,LoginCollectNotice]
		tpc := WaitForPixelColor(Homex,Homey,pc,,,5)
		if tpc = 1
		{
			GuiControl,, NB,At home
		}
		else if or tpc = 2 or tpc = 3
		{
			GuiControl,, NB, Expedition Found
			ClickS(Expeditionx,Expeditiony)
			sleep 2000
			ClickS(Expeditionx,Expeditiony)
			sleep 2000
			ClickS(Expeditionx,Expeditiony)
			loopcount++
		}
		else if tpc = 4 or tpc = 5
		{
			GuiControl,, NB, Android popup Found
			ClickS(AndroidpopupExitx,AndroidpopupExity)
			loopcount++
		}
		else if tpc = 6
		{
			GuiControl,, NB, Login Collect Found
			ClickS(LoginCollectExitx,LoginCollectExity)
			loopcount++
		}
		else if tpc = 7
		{	
			GuiControl,, NB, Login Collec tNotice
			ClickS(LoginCollectNoticey,LoginCollectNoticey)
			loopcount++
		}
		Else
		{	
			GuiControl,, NB, Initial Event notice Found
			ClickS(Dailypopx,Dailypopy)
			loopcount++
		}
		loopcount--

	}
	; Found := FindClick(A_ScriptDir "\pics\Home", "rNoxPlayer mc o5 Count1 n0")
	; while( Found == 0 )
	; {
	; 		ExpeditionCheck()
	; 		Found := FindClick(A_ScriptDir "\pics\Home", "rNoxPlayer mc o5 Count1 n0")
	; }
}

ExpeditionTransition(ClickThis,WaitForThis)
{
	GuiControl,, NB, %WaitForThis%
	Found := FindClick(A_ScriptDir "\pics\" WaitForThis, "rNoxPlayer mc o10 Count1 n0 w1000,50")
	While (Found != 1)
	{
		RFindClick("ExpeditionArrive", "rNoxPlayer mc o10 Center x"RandX " y"RandY)
		RFindClick("ExpeditionConfirm", "rNoxPlayer mc o10 Center x"RandX " y"RandY)
		RFindClick(ClickThis, "rNoxPlayer mc o10 Center x"RandX " y"RandY)
		Found := FindClick(A_ScriptDir "\pics\" WaitForThis, " rNoxPlayer mc o10 Count1 n0 w1000,50")
	}
}

TimeCheck()
{
	global FriendCollector
	global FriendChecker
	if(FriendCollector == 1)
	{
		if(FriendChecker == 1)
		{
			FormatTime, TimeString,% A_NowUTC, HHmm
			GuiControl,, NB, %TimeString%
			if TimeString between 1100 and 1115
			{ 
				FriendChecker--
				Random, FriendTime, 1900000, 1800000
				SetTimer, FriendFlag, %Friendtime%
				RFindClick("Dorm\Dorm", "rNoxPlayer mc o5 w30000,50")
				RFindClick("Dorm\Visit", "rNoxPlayer mc o5 w30000,50")
				sleep 100
				RFindClick("Dorm\MyFriends", "rNoxPlayer mc o5 w30000,50")
				RFindClick("Dorm\VisitDorm", "rNoxPlayer mc o5 w30000,50")
				RFindClick("Dorm\WaitForFriends", "rNoxPlayer mc o5 w30000,50 n0")
				FoundMessage := 0
				FoundMessage := FindClick(A_ScriptDir "\pics\Dorm\Message", "rNoxPlayer mc o30 count1 n0")
				while (FoundMessage == 0)
				{
					RFindClick("Dorm\Like", "rNoxPlayer mc o5 w30000,50")
					sleep 500
					Found := FindClick(A_ScriptDir "\pics\Dorm\Battery", "rNoxPlayer mc o5 count1 n0")
					if (Found == 1)
					{
						RFindClick("Dorm\Battery", "rNoxPlayer mc o5 w30000,50")
						RFindClick("Dorm\BatteryClose", "rNoxPlayer mc o5 w30000,50")
					}
					RFindClick("Dorm\Next", "rNoxPlayer mc o5 w30000,50")
					sleep 1000
					RFindClick("Dorm\WaitForFriends", "rNoxPlayer mc o5 w30000,50 n0")
					sleep 200
					FoundMessage := FindClick(A_ScriptDir "\pics\Dorm\Message", "rNoxPlayer mc o30 count1 n0 ")
				}
				RFindClick("Dorm\Return", "rNoxPlayer mc o5 w30000,50")
				RFindClick("Dorm\Exit", "rNoxPlayer mc o5 w30000,50")
			} 
		}
	}
}


Production()
{
	Global
	Found := FindClick(A_ScriptDir "\pics\Production\FactoryReady", "rNoxPlayer mc o5 n0 count1")
	if((ProductionTdoll == 1 || ProductionEquipment == 1) && Found == 1) 
	{
		ExpeditionTransition("Production\FactoryReady","Production\WaitForTdollProduction")
		if (ProductionTdoll == 1)
		{
			RFindClick("Production\WaitForTdollProduction", "rNoxPlayer mc o5 w30000,50 n0")
			FoundSlot1 := FindClick(A_ScriptDir "\pics\Production\TdollProductionComplete1", "rNoxPlayer mc o5 n0 count1 w2000,50")
			FoundSlot2 := FindClick(A_ScriptDir "\pics\Production\TdollProductionComplete2", "rNoxPlayer mc o5 n0 count1")
			loop,2
			{
				ProductionCounter := A_Index
				if (FoundSlot%A_Index% == 1)
				{
					RFindClick("Production\TdollProductionComplete"A_Index, "rNoxPlayer mc o5 w30000,50")
					Loop
					{
						if ( FindClick(A_ScriptDir "\pics\Production\TdollProductionStart"ProductionCounter, "rNoxPlayer mc o5 n0 count1") == 1 )
						{
							break
						}
						Else
						{
							ClickS(Safex,Safey)
							sleep 500
						}
					}
					RFindClick("Production\TdollProductionStart"A_Index, "rNoxPlayer mc o5 w30000,50")
					RFindClick("Production\StartProduction", "rNoxPlayer mc o5 w30000,50")
					sleep 1000
				}
			}
		}
		RFindClick("Production\WaitForTdollProduction", "rNoxPlayer mc o5 w30000,50 n0")
		Found := FindClick(A_ScriptDir "\pics\Production\EquipmentReady", "rNoxPlayer mc o5 count1 n0 w2000,50")
		if ( Found == 1)
		{
			RFindClick("Production\EquipmentReady", "rNoxPlayer mc o5 w30000,50")
			RFindClick("Production\WaitForTdollProduction", "rNoxPlayer mc o5 w30000,50 n0")
			FoundSlot1 := FindClick(A_ScriptDir "\pics\Production\EquipmentSlotComplete1", "rNoxPlayer mc o5 n0 count1 w2000,50")
			FoundSlot2 := FindClick(A_ScriptDir "\pics\Production\EquipmentSlotComplete2", "rNoxPlayer mc o5 n0 count1")
			FoundSlot3 := FindClick(A_ScriptDir "\pics\Production\EquipmentSlotComplete3", "rNoxPlayer mc o5 n0 count1")
			loop,3
			{
				ProductionCounter := A_Index
				if (FoundSlot%A_Index% == 1)
				{
					RFindClick("Production\EquipmentSlotComplete"A_Index, "rNoxPlayer mc o5 w30000,50")
					Loop
					{
						if ( FindClick(A_ScriptDir "\pics\Production\EquipmentSlotStart"ProductionCounter, "rNoxPlayer mc o5 n0 count1") == 1 )
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
						RFindClick("Production\EquipmentSlotStart"A_Index, "rNoxPlayer mc o5 w30000,50")
						RFindClick("Production\StartProduction", "rNoxPlayer mc o5 w30000,50")
						sleep 1000
					}
				}
			}
		}
		sleep 1000
		RFindClick("FactoryReturn", "rNoxPlayer mc o5 w30000,50")
	}
}

RSleep(time:=600)
{
	Random, rtime, time-150, time+150
	Sleep, %rtime%
	return
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
		GuiControl,, NB, %ExpeditionV%
		GuiControl,, NB, At home [Expedition only]
		ExpeditionCheck()
		if ( FactoryChecker == 1)
		{
			Random, Factorytime, 300000, 250000
			SetTimer, FactoryFlag, %Factorytime%
			FactoryChecker--
		}
		GuiControl,, NB, FactoryFlag %FactoryFlag% 
		sleep 1000
		if ( FactoryFlag == 1)
		{
			clickS(Factoryx,Factoryy)
			sleep 5000
			pc := [HPC]
			tpc := WaitForPixelColor(Homex,Homey,pc,FactoryReturnx,FactoryReturny,10)
			FactoryFlag--
		}
		Production()
	}

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
		modder := Mod(Sortiecount, 2)
		modder2 := Mod(Sortiecount + 1, 2)
		Dollcount1 := 1 + modder
		Dollcount2 := 1 + modder2
		Doll[] := [%Doll1%,%Doll2%]
		Found := 0
		ExpeditionTransition("Formation","WaitForFormation")
		WFindClick("DollList\"Doll%DollCount1%, "rNoxPlayer mc a125,125,-775,-220") ; select Doll1
		RFindClick("Filter", "rNoxPlayer mc o5 w30000,50") ; select filter
		if Doll%DollCount2% in %5Star%
		{
			RFindClick("5STAR", "rNoxPlayer mc o5 w10000,50") ;go to formation 
		}
		Else
		{
			RFindClick("4STAR", "rNoxPlayer mc o5 w10000,50") ;go to formation 
		}
		RFindClick("Filter"WeaponType, "rNoxPlayer mc o5 w30000,50")
		RFindClick("Confirm", "rNoxPlayer mc o5 w30000,50")
		sleep 200
		tpc := 0
		pc := []
		pc := [FormationProfile]
		tpc := WaitForPixelColor(FormationProfilex,FormationProfiley,pc)
		WFindClick("DollList\"Doll%DollCount2% "Profile","rNoxPlayer mc")
		sleep 500
		RFindClick("Echelon2", "rNoxPlayer mc o20 w30000,50")
		RFindClick("WaitForFormation", "rNoxPlayer mc o5 w30000,50 n0") ;wait for formation
		ClickS(Role1x,Role1y)
		RFindClick("FilterYellow", "rNoxPlayer mc o10 w30000,50")
		RFindClick("FilterReset", "rNoxPlayer mc o10 w30000,50")
		RFindClick("Filter", "rNoxPlayer mc o10 w30000,50")
		if Doll%DollCount1% in %5Star%
		{
			RFindClick("5STAR", "rNoxPlayer mc o5 w10000,50") 
		}
		Else
		{
			RFindClick("4STAR", "rNoxPlayer mc o5 w10000,50") 
		}
		RFindClick("Filter"WeaponType, "rNoxPlayer mc o5 w30000,50")
		RFindClick("Confirm", "rNoxPlayer mc o5 w30000,50")
		tpc := 0
		pc := []
		pc := [FormationProfile]
		tpc := WaitForPixelColor(FormationProfilex,FormationProfiley,pc)
		sleep 200
		WFindClick("DollList\"Doll%DollCount1% "Profile", "rNoxPlayer mc")  ; select Dollportrait1
		sleep 500
		RFindClick("FormationReturn", "rNoxPlayer mc o5 w30000,50") ; go home

		; Check expedition
		ExpeditionCheck()
	}	

	ExpeditionTransition("Combat","Emergency")
	GuiControlGet, WorldV
	RunMap(WorldV)

	GuiControl,, NB, At home

	; Check expedition
	ExpeditionCheck()
	Found := FindClick(A_ScriptDir "\pics\Home", "rNoxPlayer mc o5 Count1 n0 w5000,50")

	Sortiecount++
	RetirementCounter++
	ti := BC+1
	Menu, Main, Rename, %BC%, %ti%
	BC += 1

	; Repair
	Found := 0
	Found := FindClick(A_ScriptDir "\pics\Repair", "rNoxPlayer mc o5 Count1 n0")
	if Found >= 1
	{
		RFindClick("Repair", "rNoxPlayer mc o5 w30000,50")
		RFindClick("RepairSlot", "rNoxPlayer mc o5 w30000,50")
		sleep 1000
		WFindClick("Damage", "rNoxPlayer mc o5 w30000,50")
		RFindClick("OK", "rNoxPlayer mc o5 w30000,50")
		RFindClick("RepairQuick", "rNoxPlayer mc o5 w30000,50")
		RFindClick("RepairOK", "rNoxPlayer mc o5 w30000,50")
		RFindClick("RepairReturnFaded", "rNoxPlayer mc o5 w30000,50 ")
		RFindClick("RepairReturn", "rNoxPlayer mc o5 w30000,50")
		ExpeditionCheck()
	}

	; Dismantle

	Retirement := Mod(RetirementCounter, DisassembleCycle + 1)
	if(Retirement == DisassembleCycle)
	{
		ExpeditionTransition("Factory","TdollEnhancement")
		if(Enchancement == 1)
		{
			RFindClick("TdollEnhancement", "rNoxPlayer mc o40 w10000,50")
			RFindClick("TdollEnhancement_SelectDoll", "rNoxPlayer mc o40 w10000,50")
			sleep 500
			y:=0
			loop,2
			{
				rti := 0
				rti2 := 5
				tpc := 0
				loop
				{
					tpc := PixelGetColorS(TdollEnhancement_Lockx+180*rti,TdollEnhancement_Locky+310*y,3)
					if (tpc == TdollEnhancement_Lock)
					{
						ClickS(TdollEnhancement_Lockx+180*rti,TdollEnhancement_Locky+310*y)
						break
					}
					rti := rti+1
				}until (rti > rti2)
				if (tpc == TdollEnhancement_Lock)
				{
					break
				}
				y++
			}
			SetFilter := 1
			loop, 2
			{
				sleep 500
				RFindClick("TdollRetirementSelect", "rNoxPlayer mc oTransN,40 w30000,50")
				If(SetFilter == 1)
				{
					RFindClick("Filter", "rNoxPlayer mc o10 w30000,50")
					RFindClick("TwoStar", "rNoxPlayer mc o10 w30000,50")
					RFindClick("Confirm", "rNoxPlayer mc o10 w30000,50")
					SetFilter--
				}
				sleep 500
				rti := 0
				rti2 := 5
				Loop
				{
					ClickS(TdollRetirementSlot1x+180*rti,TdollRetirementSlot1y)
					ClickS(TdollRetirementSlot1x+180*rti,TdollRetirementSlot1y+318)
					rti := rti+1
					Sleep 10
				}Until (rti > rti2)
				RFindClick("TdollRetirementOK", "rNoxPlayer mc o5 w30000,50")
			}
			RFindClick("TdollEnhancement_Enhancement", "rNoxPlayer mc o5 w30000,50")
			RFindClick("TdollEnhancement_EnhancementOK", "rNoxPlayer mc o5 w30000,50")
		}
		if (Enchancement == 0 || Enchancement == 1)
		{
			RFindClick("Retirement", "rNoxPlayer mc o5 w30000,50")
			SetFilter := 1
			loop, 2
			{
				sleep 500
				RFindClick("TdollRetirementSelect", "rNoxPlayer mc oTransN,40 w30000,50")
				If(SetFilter == 1)
				{
					if(Enchancement == 1)
					{
						RFindClick("FilterYellow", "rNoxPlayer mc o10 w30000,50")
					}
					Else
					{
						RFindClick("Filter", "rNoxPlayer mc o10 w30000,50")
					}
					RFindClick("ThreeStar", "rNoxPlayer mc o10 w30000,50")
					if(Enchancement == 0)
					{
						RFindClick("TwoStar", "rNoxPlayer mc o10 w30000,50")
					}
					RFindClick("Confirm", "rNoxPlayer mc o10 w30000,50")
					SetFilter--
				}
				sleep 500
				rti := 0
				rti2 := 5
				Loop
				{
					ClickS(TdollRetirementSlot1x+180*rti,TdollRetirementSlot1y)
					ClickS(TdollRetirementSlot1x+180*rti,TdollRetirementSlot1y+318)
					rti := rti+1
					Sleep 10

				}Until (rti > rti2)
				RFindClick("TdollRetirementOK", "rNoxPlayer mc o5 w30000,50")
			}
			RFindClick("TdollRetirementDismantle", "rNoxPlayer mc o5 w30000,50")
			Found := 0
			Found := FindClick(A_ScriptDir "\pics\TdollRetirementDismantleConfirm", "rNoxPlayer mc o5 Count1 n0 w2000,50")
			if Found >= 1
			{
				RFindClick("TdollRetirementDismantleConfirm", "rNoxPlayer mc o5 w30000,50")
			}
			sleep 2500
		}
		RFindClick("FactoryReturn", "rNoxPlayer mc o5 w30000,50")
		ExpeditionCheck()
	}


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

; Sortie:
; {
; 	SetTimer, NBUpdate, Off
; 	SetTimer, Delay, Off
; 	BusyS := 1
; 	DT := 0
; 	TR := 0
; 	GuiControl, Hide, SSB
; 	CheckWindow()
; 	Notify("AHKCSortie", "Preparing to send sortie",1)

; 	; tpc := PixelGetColorS(FX,FY,3)
; 	; GuiControl,, NB, Color is %tpc%
; 	; sleep 2000
; 	; GuiControl,, NB, HPC is %HPC%
; 	; sleep 2000
; 	; if (tpc = HPC)
; 	; {
; 	; 	GuiControl,, NB, Color is tpc = HPC
; 	; 	sleep 2000
; 	; }

; 	; loop, 6
; 	; {
; 	; 	GuiControl,, NB, Checking HP %A_Index%
; 	; 	tpc := PixelGetColorS(ShipHealthx,ShipHealthy[A_Index],3)
; 	; 	GuiControl,, NB, Color is %tpc%
; 	; 	if (tpc = RedHealthPC)
; 	; 	{
; 	; 		GuiControl,, NB, RED detected
; 	; 		if (world !=1 and map != 1)
; 	; 		{
; 	; 			NC := Nodes
; 	; 		}
; 	; 	}
; 	; }

; 	if not (BP = 1 and DisableCriticalCheck = 1)
; 	{
; 		if not (world = 1 and map = 1)
; 		{
; 			Repair()
; 		}
; 	}
; 	if not (BP = 1 and DisableResupply = 1)
; 	{
; 		Resupply(1)
; 	}
; 	tpc2 := PixelGetColorS(Gx,Gy,3)
; 	if (tpc2 != HPC)
; 	{
; 		ClickS(Hx,Hy)
; 		GuiControl,, NB, Waiting for home screen
; 		pc := []
; 		pc := [HPC]
; 		WaitForPixelColor(Gx,Gy,pc)
; 	}

; 	ClickS(Sx,Sy)
; 	GuiControl,, NB, Waiting for sortie screen
; 	pc := []
; 	pc := [SPC]
;     WaitForPixelColor(Gx,Gy,pc)
; 	ClickS(S2x,S2y)
; 	GuiControl,, NB, Waiting for sortie selection screen
; 	pc := []
; 	pc := [S2PC]
; 	WaitForPixelColor(Gx,Gy,pc)
; 	tf := SPGx[World]
; 	Sleep MiscDelay
; 	ClickS(tf,PGy)
; 	GuiControl,, NB, Starting sortie
; 	Sleep MiscDelay
; 	if(Map > 4)
; 	{
; 		pc := []
; 		pc := [PG2SPC]
; 		tpc := WaitForPixelColor(PGExtrax,PGExtray,pc,Extrax,Extray)
; 	}
; 	tfx := MAPx[Map]
; 	tfy := MAPy[Map]
; 	ClickS(tfx,tfy)
; 	Sleep MiscDelay
; 	ClickS(ESx,ESy)
; 	Sleep MiscDelay
; 	ClickS(ESx,ESy)
; 	Notify("AHKCSortie", "Sortie started",1)
; 	if SortieInterval != -1
; 	{
; 		SetTimer, Delay, %SortieInterval%
; 		TR := 1
; 		TCS := A_TickCount
; 	}
; 	NC := 1
; 	Loop
; 	{
; 		GuiControl,, NB, Waiting for compass/formation
; 		pc := []
; 		pc := [CPC,FPC,IBPC]
; 		tpc := WaitForPixelColor(LAx,LAy,pc,,,30)
; 		Sleep MiscDelay
; 		if tpc = 1
; 		{
; 			ClickS(ESx,ESy)
; 			sleep 1000
; 			GuiControl,, NB, Waiting for formation
; 			pc := []
; 			pc := [FPC,CPC,ResourceSortiePC,IBPC]
; 			tpc2 := WaitForPixelColor(LAx,LAy,pc,,,30)
; 			if tpc2 = 1
; 			{
; 				Sleep MiscDelay
; 				if(World = 1 and Map = 5)
; 				{
; 					ClickS(LAbreastx,LAbreasty)
; 				}
; 				else if(world = 3 and map = 2)
; 				{
; 					ClickS(L_doublex,L_doubley)
; 				}
; 				else
; 				{
; 					ClickS(LAx,LAy)
; 				}
; 			}
; 			else if tpc2 = 2
; 			{
; 				ClickS(ESx,ESy)
; 				GuiControl,, NB, FIRST COMPASS PASSED Waiting for formation
; 				pc := []
; 				pc := [FPC,CPC,ResourceSortiePC,IBPC]
; 				tpc3 := WaitForPixelColor(LAx,LAy,pc,,,30)
; 				if tpc3 = 1
; 				{
; 					Sleep MiscDelay
; 					if(World = 1 and Map = 5)
; 					{
; 						ClickS(LAbreastx,LAbreasty)
; 					}
; 					else
; 					{
; 						ClickS(LAx,LAy)
; 					}
; 				}
; 				else if tpc3 = 2
; 				{
; 					pc := []
; 					pc := [HPC,HEPC]
; 					WaitForPixelColor(Gx,Gy,pc,ESBx,ESBy)
; 					break
; 				}
; 				else if tpc3 = 3
; 				{
; 					pc := []
; 					pc := [HPC,HEPC]
; 					WaitForPixelColor(Gx,Gy,pc,ESBx,ESBy)
; 					break
; 				}

; 			}
; 			else if tpc2 = 3
; 			{
; 				pc := []
; 				pc := [HPC,HEPC]
; 				WaitForPixelColor(Gx,Gy,pc,ESBx,ESBy)
; 				break
; 			}
; 		}
; 		else if tpc = 2
; 		{
; 			if(World = 1 and Map = 5)
; 			{
; 				ClickS(LAbreastx,LAbreasty)
; 			}
; 			else
; 			{
; 				ClickS(LAx,LAy)
; 			}
; 		}
; 		GuiControl,, NB, Waiting for results
; 		pc := []
; 		pc := [SRPC,NBPC,HPC,HEPC]
; 		WaitForPixelColor(Gx,Gy,pc,,,250)
; 		tpc := WaitForPixelColor(Gx,Gy,pc)
; 		if tpc = 2
; 		{
; 			GuiControl,, NB, Cancelling night battle
; 			Sleep 3000
; 			ClickS(CNBx,CNBy)
; 			GuiControl,, NB, Waiting for score1
; 			pc := []
; 			pc := [HealthScreenPC]
; 			WaitForPixelColor(HealthScreenx,HealthScreeny,pc,HealthScreenx,HealthScreeny,250)
; 			GuiControl,, NB, Checking HP
; 			sleep 1000
; 			loop, 6
; 			{
; 				GuiControl,, NB, Checking HP %A_Index%
; 				tpc := PixelGetColorS(ShipHealthx,ShipHealthy[A_Index],3)
; 				GuiControl,, NB, Color is %tpc%
; 				if (tpc = RedHealthPC)
; 				{
; 					GuiControl,, NB, RED detected
; 					sleep 1000
; 					if(world = 1 and map = 1)
; 					{

; 					}
; 					Else
; 					{
; 						NC := Nodes
; 					}
; 				}
; 			}
; 		}
; 		else if (tpc = 3 or tpc = 4)
; 		{
; 			Break
; 		}
; 		else if (tpc != 2 or tpc != 3 or tpc != 4)
; 		{
; 			GuiControl,, NB, Waiting for score2
; 			pc := []
; 			pc := [HealthScreenPC]
; 			WaitForPixelColor(HealthScreenx,HealthScreeny,pc,HealthScreenx,HealthScreeny,250)
; 			GuiControl,, NB, Checking HP
; 			sleep 1000
; 			loop, 6
; 			{
; 				GuiControl,, NB, Checking HP %A_Index%
; 				tpc := PixelGetColorS(ShipHealthx,ShipHealthy[A_Index],3)
; 				GuiControl,, NB, Color is %tpc%
; 				if (tpc = RedHealthPC)
; 				{
; 					GuiControl,, NB, RED detected
; 					sleep 1000
; 					if(world = 1 and map = 1)
; 					{

; 					}
; 					Else
; 					{
; 						NC := Nodes
; 					}
; 				}
; 			}
; 		}
; 		GuiControl,, NB, Waiting...
; 		ClickS(FX,FY)
; 		GuiControl,, NB, Checking next screen...
; 		if(NC >= Nodes)
; 		{
; 			GuiControl,, NB, Sortie ending
; 			sleep 1000
; 		}
; 		pc := []
; 		pc := [HPC,HPC,HPC,HPC,HEPC,HEPC,HEPC,CSPC]
; 		tpc := WaitForPixelColor(Gx,Gy,pc,ESBx,ESBy)
; 		if tpc != 8
; 		{
; 			Break
; 		}
; 		else if tpc = 8
; 		{
; 			GuiControl,, NB, Continue screen
; 			Sleep 2000
; 			if (NC >= Nodes)
; 			{
; 				GuiControl,, NB, Ending sortie
; 				ClickS(ESBx,ESBy)
; 			}
; 			else
; 			{
; 				Notify("AHKCSortie", "Proceeding to next node",2)
; 				GuiControl,, NB, Continuing Sortie
; 				ClickS(CSBx,CSBy)
; 			}
; 		}
; 		else
; 		{
; 			break
; 		}
; 		NC += 1
; 	}Until NC > Nodes
; 	; tpc6 := PixelGetColorS(ShipHealthx,ShipHealthy%A_Index%,3)
; 	; if (tpc6 = ResourceSortiePC)
; 	; {
; 	; 	GuiControl,, NB, Resource screen
; 	; 	ClickS(ESBx,ESBy)
; 	; 	Sleep 3000

; 	; }
; 	;after selecting compass goes to resource screen
; 	GuiControl,, NB, Waiting for home screen
; 	pc := []
; 	pc := [HPC,HEPC]
; 	WaitForPixelColor(Gx,Gy,pc,ESBx,ESBy)
; 	Notify("AHKCSortie", "Sortie completed",1)
; 	GuiControl,, NB, Idle
; 	BusyS := 0
; 	GuiControl, Show, SSB
; 	if SortieInterval != -1
; 	{
; 		BP := 0
; 		SetTimer, NBUpdate, 2000
; 	}
; 	return
; }

; Resupply(r)
; {
;     global
; 	GuiControl,, NB, Resupplying...
; 	tpc := 0
; 	tpc := PixelGetColorS(Gx,Gy,3)
; 	if (tpc = HPC)
; 	{
;         loop
; 		{
;         Random, random_screen , 1, 5
;         Goto, %random_screen%
; 		1:
; 		GuiControl,, NB, 1
; 		ClickS(Rx,Ry)
; 		break
; 		2:
; 		GuiControl,, NB, 2
; 		ClickS(Refitx,Refity)
; 		pc := []
; 		pc := [RPC]
; 		WaitForPixelColor(Gx,Gy,pc,SResupplyx,SResupplyy)
; 		break
; 		3:
; 		GuiControl,, NB, 3
; 		ClickS(Factoryx,Factoryy)
; 		pc := []
; 		pc := [RPC]
; 		WaitForPixelColor(Gx,Gy,pc,SResupplyx,SResupplyy)
; 		break
; 		4:
; 		GuiControl,, NB, 4
; 		ClickS(Repairx,Repairy)
; 		pc := []
; 		pc := [RPC]
; 		WaitForPixelColor(Gx,Gy,pc,SResupplyx,SResupplyy)
; 		break
; 		5:
; 		GuiControl,, NB, 5
; 		ClickS(Fleetx,Fleety)
; 		pc := []
; 		pc := [RPC]
; 		WaitForPixelColor(Gx,Gy,pc,SResupplyx,SResupplyy)
; 		break
; 		}
; 	}
; 	else if (tpc != RPC)
;     {
;         ClickS(Hx,Hy)
; 		pc := []
; 		pc := [HPC]
;         WaitForPixelColor(Gx,Gy,pc)
;         ClickS(Rx,Ry)
;     }
; 	pc := []
; 	pc := [RPC]
; 	WaitForPixelColor(Gx,Gy,pc)
; 	GuiControl,, NB, Resupplying fleet %r%
;     Sleep MiscDelay
; 	rti := 0
; 	rti2 := 5
; 	if (world = 1 and map = 1)
; 	{
; 		rti2 := 0
; 	}
; 	Loop
; 	{
; 		ClickS(SAx,SAy+50*rti)
; 		rti := rti+1
; 		Sleep 1
; 	}Until (rti > rti2)
; 	ClickS(ESx,ESy)
; 	pc := []
; 	pc := [RPC]
; 	WaitForPixelColor(Gx,Gy,pc)
; 	return
; }

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

#Include %A_ScriptDir%/Functions/Click.ahk
#Include %A_ScriptDir%/Functions/TimerUtils.ahk
#Include %A_ScriptDir%/Functions/PixelCheck.ahk
#Include %A_ScriptDir%/Functions/Pause.ahk
#Include %A_ScriptDir%/Functions/Window.ahk
#Include %A_ScriptDir%/Functions/PixelSearch.ahk
#Include %A_ScriptDir%/Functions/PixelMap.ahk
#Include %A_ScriptDir%/Functions/Notify.ahk
#Include %A_ScriptDir%/Functions/FindClick.ahk


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
	5Star = TYPE97,OTS14,HK416,G41,TYPE95,G11,FAL,WA2000
	4Star = 
}

GuiClose:
{
	WinGetPos,TWinX,TWinY
	IniWrite,%TWinX%,config.ini,Variables,LastXS
	IniWrite,%TWinY%,config.ini,Variables,LastYS
	ExitApp
}
