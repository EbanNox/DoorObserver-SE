Scriptname ObserverPlayerOnLoadScript extends ReferenceAlias  

FormList Property aaaDoorsList auto
string DG = "Dawnguard.esm"
string DB = "Dragonborn.esm"

Event onInit()
	onPlayerLoadGame()
endEvent

Event onLoad()
	onPlayerLoadGame()
endEvent

Function onPlayerLoadGame()
; DLC Dawnguard , chek if theese Forms are valid as same in for Skyrim SE porting, change this to SE version.
	if (Game.getFormFromFile(0xf812, DG))
		Form [] doors = new Form[3]
		doors[0] = Game.getFormFromFile(0xd257, DG)
		doors[1] = Game.getFormFromFile(0x13b82, DG)
		doors[2] = Game.getFormFromFile(0x13df5, DG)
		int i = 0
		while (i < doors.Length)
			if (!aaaDoorsList.hasForm(doors[i]))
				aaaDoorsList.addForm(doors[i])
			endIf
			i += 1
		endWhile
		debug.notification("Observer: Dawnguard support.")
	endIf
; DLC Dragonborn
	if (Game.getFormFromFile(0x18616, DB))
		Form [] doors = new Form[8]
		doors[0] = Game.getFormFromFile(0x2c417, DB)
		doors[1] = Game.getFormFromFile(0x38bad, DB)
		doors[2] = Game.getFormFromFile(0x3a740, DB)
		doors[3] = Game.getFormFromFile(0x3a742, DB)
		doors[4] = Game.getFormFromFile(0x3c4a7, DB)
		doors[5] = Game.getFormFromFile(0x3c4aa, DB)
		doors[6] = Game.getFormFromFile(0x3ca70, DB)
		doors[7] = Game.getFormFromFile(0x3cfcc, DB)
		int i = 0
		while (i < doors.Length)
			if (!aaaDoorsList.hasForm(doors[i]))
				aaaDoorsList.addForm(doors[i])
			endIf
			i += 1
		endWhile
		debug.notification("Observer: Dragonborn support.")
	endIf
endFunction
