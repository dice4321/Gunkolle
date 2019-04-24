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
Transition("CombatTdollEnhancement","Retirement")
	sleep 2000
	RFindClick("Retirement", "rNoxPlayer mc o50 w30000,50")
	sleep 3000
	Transition("RetirementNotClicked","RetirementClicked") 
	RFindClick("TdollRetirementSelect", "rNoxPlayer mc o75 w30000,50")
	sleep 500
	RFindClick("SmartSelect", "rNoxPlayer mc o75 w30000,50")
	Sleep 1700
	RFindClick("ConfirmRet", "rNoxPlayer mc o75 w30000,50")
	RFindClick("TdollRetirementDismantle", "rNoxPlayer mc o75 w30000,50")
	Sleep 2000
	RFindClick("FactoryReturn", "rNoxPlayer mc o50 w30000,50")
	Transition("Combat","CombatPage")

}
	return

