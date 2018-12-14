EnhancementDollSwitcher()
{	
	Global
	y:=0
	loop,2
	{
		rti := 0
		rti2 := 5
		tpc := 0
		loop
		{
			tpc := PixelGetColorS(TdollEnhancement_Lockx+179*rti,TdollEnhancement_Locky+304*y,1)
			if (tpc == TdollEnhancement_Lock)
			{
				ClickS(TdollEnhancement_Lockx+180*rti,TdollEnhancement_Locky+304*y)
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
}

Retirement()
{
	Global
	if(true)
	{
		Transition("CombatTdollEnhancement","Retirement")
		if (Enhancement == 0 || Enhancement == 1)
		{
			RFindClick("Retirement", "rNoxPlayer mc o50 w30000,50")
			SetFilter := 1
			done := 0
			while(done != 1)
			{
				RFindClick("TdollRetirementSelect", "rNoxPlayer mc o75 w30000,50")
				sleep 1000
				If(SetFilter == 1)
				{
					RFindClick("Filter", "rNoxPlayer mc o20 w30000,50")
					RFindClick("ThreeStar", "rNoxPlayer mc o20 w30000,50")
					if(Enhancement == 0)
					{
						RFindClick("TwoStar", "rNoxPlayer mc o20 w30000,50")
					}
					RFindClick("Confirm", "rNoxPlayer mc o20 w30000,50")
					SetFilter--
					NoStopFindClick("TdollFodderWait","rNoxPlayer mc o30 w30000,50 n0")
					sleep 1000
					rti := 0
					rti2 := 5
					Loop
					{
						ClickS(TdollRetirementSlot1x+180*rti,TdollRetirementSlot1y)
						ClickS(TdollRetirementSlot1x+180*rti,TdollRetirementSlot1y+318)
						rti := rti+1
						Sleep 10

					}Until (rti > rti2)
				}
				RFindClick("SmartSelect", "rNoxPlayer mc o50 Count1")
				sleep 500
				Found := 0
				Found := FindClick(A_ScriptDir "\pics\SmartSelect", "rNoxPlayer mc o50 Count1 n0")
				if Found >= 1
				{
					RFindClick("Cancel", "rNoxPlayer mc o50 w30000,50")
					done := 1
				}
				Else
				{
					RFindClick("TdollRetirementOK", "rNoxPlayer mc o50 w30000,50")
				}
				RFindClick("TdollRetirementDismantle", "rNoxPlayer mc o50 w30000,50")
				Found := 0
				Found := FindClick(A_ScriptDir "\pics\TdollRetirementDismantleConfirm", "rNoxPlayer mc o50 Count1 n0 w1000,50")
				if Found >= 1
				{
					RFindClick("TdollRetirementDismantleConfirm", "rNoxPlayer mc o50 w30000,50")
				}
			}
		}
		if(Enhancement == 1)
		{
			ClickTilGone("TdollEnhancement", "rNoxPlayer mc o40 w10000,50")
			RFindClick("TdollEnhancement_SelectDoll", "rNoxPlayer mc o40 w10000,50 n0")
			ClickS(EnhancementSelectx,EnhancementSelecty)
			RFindClick("FilterYellow", "rNoxPlayer mc o20 w30000,50")
			RFindClick("FilterReset", "rNoxPlayer mc o20 w30000,50")
			ClickTilGone("TdollFodderWait","rNoxPlayer mc o30 w30000,50 n0")
			EnhancementDollSwitcher()
			SetFilter := 1
			done := 0
			while(done != 1)
			{
				sleep 500
				RFindClick("TdollRetirementSelect", "rNoxPlayer mc o75 w30000,50")
				If(SetFilter == 1)
				{
					RFindClick("Filter", "rNoxPlayer mc o20 w30000,50")
					RFindClick("TwoStar", "rNoxPlayer mc o20 w30000,50")
					RFindClick("Confirm", "rNoxPlayer mc o20 w30000,50")
					SetFilter--
				}
				; rti := 0
				; rti2 := 5
				; Loop
				; {
				; 	ClickS(TdollRetirementSlot1x+180*rti,TdollRetirementSlot1y)
				; 	ClickS(TdollRetirementSlot1x+180*rti,TdollRetirementSlot1y+318)
				; 	rti := rti+1
				; 	Sleep 10
				; }Until (rti > rti2)
				RFindClick("SmartSelect", "rNoxPlayer mc o50 Count1")
				Found := 0
				Found := FindClick(A_ScriptDir "\pics\SmartSelect", "rNoxPlayer mc o50 Count1 n0")
				if Found >= 1
				{
					RFindClick("Cancel", "rNoxPlayer mc o50 w30000,50")
					done := 1
				}
				Else
				{
					RFindClick("TdollRetirementOK", "rNoxPlayer mc o50 w30000,50")
				}
				RFindClick("TdollEnhancement_Enhancement", "rNoxPlayer mc o50 w30000,50")
				RFindClick("TdollEnhancement_EnhancementOK", "rNoxPlayer mc o50 w30000,50")
			}
		}
		RFindClick("FactoryReturn", "rNoxPlayer mc o50 w30000,50")
		Transition("Combat","CombatPage")
	}
	return
}
