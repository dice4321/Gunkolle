;PixelSearch v1.71214

RPixelSearch()
{
	global
	local i := 1
	local tx
	local ty
	local cy
	local PSS
	local RPTL
	local RPTR
	local run
	loop
	{
		WinActivate, ahk_id %uid%
		PSS := 0
		tx := 0
		ty := 0
		cy := WinH
		run := 0
		RPTL := 0
		RPTR := 0
		loop
		{
			run := run + 1
			PixelSearch, BX1, BY1, tx, ty, WinW, cy, RPN, 1, Fast RGB
			if (ErrorLevel = 0)
			{
				PixelGetColor, RPTL, BX1-1, BY1, RGB
				PixelGetColor, RPTR, BX1+1, BY1, RGB
				if (RPTL = RPNL and RPTR = RPNR)
				{
					PSS := 1
					break
				}
				if (++tx >= WinW)
				{
					tx := 0
					ty := ty + 1
					cy := ty
				}
				else
				{
					tx := BX1+1
					ty := BY1
					cy := BY1
				}
			}
			else if (run = 1)
			{
				break
			}
			else
			{
				tx := 0
				ty := ty + 1
				cy := WinH
			}
			
		} until ty >= WinH
		if (PSS = 0)
		{
			WinActivate, ahk_id %uid%
			PSS := 0
			tx := 0
			ty := 0
			cy := WinH
			RPTL := 0
			RPTR := 0
			run := 0
			loop
			{
				run := run + 1
				PixelSearch, BX1, BY1, tx, ty, WinW, cy, RPD, 1, Fast RGB
				if (ErrorLevel = 0)
				{
					PixelGetColor, RPTL, BX1-1, BY1, RGB
					PixelGetColor, RPTR, BX1+1, BY1, RGB
					if (RPTL = RPDL and RPTR = RPDR)
					{
						PSS := 1
						break
					}
					if (++tx >= WinW)
					{
						tx := 0
						ty := ty + 1
						cy := ty
					}
					else
					{
						tx := BX1+1
						ty := BY1
						cy := BY1
					}
				}
				else if (run = 1)
				{
					break
				}
				else
				{
					tx := 0
					ty := ty + 1
					cy := WinH
				}
				
			} until ty >= WinH
		}
		if PSS = 1
		{
			if not Class = 0
			{
				XDiff := BX1 - 678
				YDiff := BY1 - 17
			}
			FX := BX1 + 0
			FY := BY1 + 0
			PixelMap()
			GuiControl,, NB, Ready
			return
		}
		else
		{
			GuiControl,, NB, Invalid Screen, Retrying (%i%)
			;MsgBox % BX1 " " BY1 " " tx " " ty " " WinW " " cy " " RPN
			Sleep 1000
			i += 1
			if i > 30
			{
				GuiControl,, NB, Could not find reference pixel, unpause script to try again
				i := 1
				Pause
			}
		}
	}
}