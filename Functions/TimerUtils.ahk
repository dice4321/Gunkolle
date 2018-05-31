;TimerUtils v1.51230

ParseTime(ss)
{
    global NB
    sl := StrLen(ss)
    i := 0
    ii := 0
    tt := 0
	mx := 1000
	cc := 0
    loop
    {
        ts := SubStr(ss,sl,1)
        if ts is integer
        {
			i := i + ts*10**ii
			ii += 1
			if sl = 1
			{
				tt := tt + i * mx
				return tt
			}
        }
        else if ts is alpha
        {
			if i > 0
			{
				tt := tt + i * mx
			}
			if ts = h
			{
				mx := 3600000
			}
			else if ts = m
			{
				mx := 60000
			}
			else if ts = s
			{
				mx := 1000
			}
			else
			{
				GuiControl,, NB, Invalid time input
				Exit
			}
			ii := 0
			i := 0
        }
		else if ts = :
		{
			if cc = 0
			{
				tt := tt + i * 1000
				mx := 60000
			}
			else if cc = 1
			{
				tt := tt + i * 60000
				mx := 3600000
			}
			else
			{
				GuiControl,, NB, Invalid time input
				Exit
			}
			if sl = 1
			{
				return tt
			}
			i := 0
			ii := 0
			cc += 1
		}
		else
		{
			GuiControl,, NB, Invalid time input
			Exit
		}
        sl := sl - 1
    }
}

IsExpedWithinRange( d, lc, uc)
{
	global
	local i := 2
	local GRT
	loop
	{
		GRT := GetRemainingTime(TCS[i],TCL[i])
		if (GRT > d and GRT < d+uc and d < GRT+lc)
		{
			d := GRT+10000
			i := 1
		}
		i += 1
	}Until i > 4
	return d
}

GetRemainingTime(n, n2, b := 0) 
{	
	global Busy
	i := n+n2-A_TickCount
	if b = 1
	{
		if (i < 60000 and Busy = 0)
		{
			IniWrite,1,config.ini,Do Not Modify,Busy
			Busy := 1
		}
	}
	return i
}

MS2HMS(ms)
{
	if ms < 0
	{
		return "00:00:00"
	}
	var := Floor(ms/3600000)
	ms := ms - var*3600000
	if (var<10) 
		tString := "0" . var . ":"
	else 
		tString := var . ":"
	
	var := Floor(ms/60000)
	ms := ms - var*60000
	if (var<10) 
		tString := tString . "0" . var . ":"
	else 
		tString := tString . var . ":"
	var := Floor(ms/1000)
	if (var<10) 
		tString := tString . "0" . var
	else 
		tString := tString . var
	return tString
}