;Pause v1.0

Pause2:
{
	GuiControl,, NB, PAUSED
	Pause
	if ( A_IsPaused == 0)
	{
	GuiControl,, NB, UNPAUSED
	}
}

Pause::Pause