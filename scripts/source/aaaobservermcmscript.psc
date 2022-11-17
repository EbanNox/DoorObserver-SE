Scriptname aaaObserverMCMScript extends SKI_ConfigBase

Quest Property aaaObserverQuest auto
aaaObserverQuestScript Property OQS auto

int [] SGDesc = None
String [] SGLabel = None
bool enabled = false
int timeout = 0
bool applied = false

Event OnPageReset(string page)
	if (page == Pages[0])
		SetupGeneric()
	endIf
endEvent

Function SetupGeneric()
	SGDesc = new Int[3]
	SGLabel = new String[3]
	SGLabel[0] = "$Enabled"
	SGLabel[1] = "$Timeout"
	SGLabel[2] = "$Apply to Player"
	SetCursorFillMode(LEFT_TO_RIGHT)
	enabled = aaaObserverQuest.isRunning()
	timeout = OQS.failsafeCount
	applied = OQS.playerApplied
	SGDesc[0] = AddToggleOption(SGLabel[0], enabled)
	SGDesc[1] = AddSliderOption(SGLabel[1], timeout, "{0}")
	SGDesc[2] = AddToggleOption(SGLabel[2], applied)
endFunction

Event onOptionSelect(int option)
	if (option == SGDesc[0]) ; MOD Enable/Disable
		enabled = aaaObserverQuest.isRunning()
		enabled = !enabled
		SetToggleOptionValue(SGDesc[0], enabled)
		SetOptionFlags(SGDesc[0], OPTION_FLAG_DISABLED)
		SetOptionFlags(SGDesc[1], OPTION_FLAG_DISABLED)
		registerForSingleUpdate(1)
	elseIf (option == SGDesc[2]) ; Apply to Player
		applied = OQS.playerApplied
		applied = !applied
		OQS.playerApplied = applied
		SetToggleOptionValue(SGDesc[2], applied)
	endIf
endEvent

Event onOptionSliderOpen(int option)
	if (option == SGDesc[1]) ; Timeout
		SetSliderDialogStartValue(OQS.failsafeCount)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(1, 120)
		SetSliderDialogInterval(1)
	endIf
endEvent

Event onOptionSliderAccept(int option, float value)
	if (option == SGDesc[1]) ; Timeout
		OQS.failsafeCount = value as int
		SetSliderOptionValue(SGDesc[1], value as int, "{0}")
	endIf
endEvent

Event onOptionDefault(int option)
	if (option == SGDesc[1]) ; Timeout
		SetSliderOptionValue(SGDesc[1], 20, "{0}")
	elseIf (option == SGDesc[2]) ; Applied to Player
		OQS.playerApplied = !OQS.playerApplied
		applied = OQS.playerApplied
		SetToggleOptionValue(SGDesc[2], applied)
	endIf
endEvent

Event onOptionHighlight(int option)
	if (option == SGDesc[0])
		SetInfoText("$Enables/disables door observer. Exit MCM menu to apply.")
	elseIf (option == SGDesc[1])
		SetInfoText("$Determines how long seconds NPC tries to close a door. If NPC cannot close the door within this period, the door will be left open.")
	elseIf (option == SGDesc[2])
		SetInfoText("$Applies this function to player. Doors will be closed when you passed them.")
	endIf
endEvent

Event onUpdate()
	if (enabled)
		aaaObserverQuest.start()
	else
		aaaObserverQuest.stop()
	endIf
endEvent