Scriptname aaaDoorCheckBehindEffectScript extends activemagiceffect  

FormList Property aaaDoorsList auto
Spell Property aaaDoorCheckBehindAbility auto
Quest Property aaaObserverQuest auto
aaaObserverQuestScript Property OQS auto

int failsafeCount = 20
int currentCount = 0

Event onEffectStart(Actor akTarget, Actor akCaster)
	bool done = false
	currentCount = 0
	failsafeCount = OQS.failsafeCount
	done = doorCheck(akTarget)
	if (!done)
		float speed = akTarget.getAv("SpeedMult")
		if (speed >= 100.0 && speed <= 300.0)
			registerForSingleUpdate(100/speed)
		else
			registerForSingleUpdate(1)
		endIf
	else
		akTarget.removeSpell(aaaDoorCheckBehindAbility)
	endIf
endEvent

Event onUpdate()
	Actor akTarget = getTargetActor()
	currentCount += 1
	bool done = false
	if (self)
		done = doorCheck(akTarget)
		if (!done && aaaObserverQuest.isRunning() && currentCount < failsafeCount)
			float speed = akTarget.getAv("SpeedMult")
			if (speed >= 100.0 && speed <= 300.0)
				registerForSingleUpdate(100/speed)
			else
				registerForSingleUpdate(1)
			endIf
		else
			akTarget.removeSpell(aaaDoorCheckBehindAbility)
		endIf
	endIf
endEvent

bool Function doorCheck(Actor akTarget)
	float x = akTarget.getPositionX()
	float y = akTarget.getPositionY()
	float z = akTarget.getPositionZ()
	float ang = 180+akTarget.getAngleZ()
	float distance = 300
	x += Math.sin(ang)*distance
	y += Math.cos(ang)*distance
	ObjectReference doorRef = Game.findClosestReferenceOfAnyTypeInList(aaaDoorsList, x, y, z, distance)
	if (doorRef && !akTarget.isWeaponDrawn())
		Actor after = Game.findClosestActorFromRef(doorRef, distance/2)
		if (after == None)
			float evaluatedDistance = distance
			if (akTarget.isRunning())
				evaluatedDistance *= 1.5
			endIf
			if (akTarget.isSprinting())
				evaluatedDistance *= 2.0
			endIf
			if (doorRef.getDistance(akTarget) <= evaluatedDistance)
				if (doorRef.getOpenState() == 1)
					doorRef.setOpen(0)
					return true
				endIf
			endIf
		endIf
	endIf
	return false
endFunction