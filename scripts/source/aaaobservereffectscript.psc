Scriptname aaaObserverEffectScript extends activemagiceffect  

FormList Property aaaDoorsList auto
Spell Property aaaDoorCheckBehindAbility auto
Spell Property aaaObserverAbility auto
Quest Property aaaObserverQuest auto

Event onEffectStart(Actor akTarget, Actor akCaster)
	onUpdate()
endEvent

Event onUpdate()
	if (self)
		Actor akTarget = getTargetActor()
		if (aaaObserverQuest.isRunning())
			periodicObservation(akTarget)
			float speed = akTarget.getAv("SpeedMult")
			if (speed >= 100.0 && speed <= 300.0)
				registerForSingleUpdate(100/speed)
			else
				registerForSingleUpdate(1)
			endIf
		else
			akTarget.removeSpell(aaaObserverAbility)
		endIf
	endIf
endEvent

Function periodicObservation(Actor akTarget)
	doorObserver(akTarget)
endFunction

Function doorObserver(Actor akTarget)
	if (akTarget.hasSpell(aaaDoorCheckBehindAbility))
		return
	elseIf (akTarget.getAv("WaitingForPlayer") != 0 && akTarget != Game.getPlayer())
		return
	elseIf (akTarget.isWeaponDrawn())
		return
	endIf
	float x = akTarget.getPositionX()
	float y = akTarget.getPositionY()
	float z = akTarget.getPositionZ()
	float ang = akTarget.getAngleZ()
	float distance = 150
	float evaluatedDistance = distance
	if (akTarget.isRunning())
		evaluatedDistance *= 1.5
	endIf
	if (akTarget.isSprinting())
		evaluatedDistance *= 2.0
	endIf
	x += Math.sin(ang)*evaluatedDistance
	y += Math.cos(ang)*evaluatedDistance
	ObjectReference doorRef = Game.findClosestReferenceOfAnyTypeInList(aaaDoorsList, x, y, z, evaluatedDistance)
	if (doorRef)
		if (!akTarget.hasMagicEffect(aaaDoorCheckBehindAbility.getNthEffectMagicEffect(0)))
			akTarget.removeSpell(aaaDoorCheckBehindAbility)
		endIf
		akTarget.addSpell(aaaDoorCheckBehindAbility, false)
	endIf
endFunction