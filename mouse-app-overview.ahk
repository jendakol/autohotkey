#SingleInstance force

CoordMode("Mouse", "Screen")
SetTimer(mouse_position, 100)
return

mouse_position()
{
	static IsThere := false

	MouseGetPos(&xpos, &ypos)
	if (xpos <= 5 and ypos <= 5) {
		if (IsThere = false) {
			;OutputDebug "yay " IsThere " " A_TickCount "`n"
			Send "#{Tab}"
			IsThere := true
		}
	} else IsThere := false

	Return
}