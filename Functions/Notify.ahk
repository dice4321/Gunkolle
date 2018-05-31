;Notify v1.60803

Notify(n,m,i)
{
	global NotificationLevel
	if (NotificationLevel >= i)
	{
		TrayTip, %n%, %m%,,17
	}
	return
}