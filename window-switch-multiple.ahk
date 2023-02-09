!;::
{
	static LastRun := 0
	static QuickPress := 0

	Now := A_TickCount

	if (Now - LastRun < 400)
		QuickPress++
	else
		QuickPress := 0

	OutputDebug '`n`nNow: ' Now ' LastRun: ' LastRun ' QuickPress: ' QuickPress '`n'



	OldClass := WinGetClass("A")
	ActiveProcessName := WinGetProcessName("A")
	WinClassCount := WinGetCount("ahk_exe " ActiveProcessName)
	ActiveId := WinGetID("A")
	OutputDebug 'Current:    ' ActiveId '/' OldClass '/' ActiveProcessName '/' WinGetTitle("ahk_id" ActiveId) "`n"

	if (WinClassCount = 1)
		Return

	ToSkip := QuickPress
	OutputDebug 'Will skip ' ToSkip ' of ' WinClassCount '`n'

	ids := WinGetList("ahk_exe " ActiveProcessName)
	for SiblingId in ids {
		if (WinGetClass("ahk_id" SiblingId) != OldClass)
			continue

		OutputDebug 'Found:      ' SiblingId '/' WinGetClass("ahk_id" SiblingId) '/' WinGetProcessName("ahk_id" SiblingId) '/' WinGetTitle("ahk_id" SiblingId) '`n'

		if (SiblingId != ActiveId && ToSkip-- <=0) {
			OutputDebug 'Switch to:  ' SiblingId '/' WinGetClass("ahk_id" SiblingId) '/' WinGetProcessName("ahk_id" SiblingId) '/' WinGetTitle("ahk_id" SiblingId) '`n'
			WinActivate("ahk_id" SiblingId)
			break
		}
	}


	LastRun := A_TickCount
}