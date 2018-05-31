;StayAwake v1.0

StayAwake()
{
	SetTimer, MoveMouse, 60000	
}

MoveMouse:
{
    MouseMove, 1, 0, 1, R  ;Move the mouse one pixel to the right
    MouseMove, -1, 0, 1, R ;Move the mouse back one pixel
	SetTimer, MoveMouse, 60000
	return
}