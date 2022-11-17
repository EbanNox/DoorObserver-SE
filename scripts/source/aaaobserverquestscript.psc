Scriptname aaaObserverQuestScript extends Quest  

FormList Property aaaObserverAbilityList auto
FormList Property aaaDoorsList auto
Keyword Property ActorTypeNPC auto

int Property failsafeCount = 20 auto
int Property CombatWait = 1 auto
int Property NormalWait = 5 auto
bool Property playerApplied = false auto

Event onInit()
	registerForSingleUpdate(5)
endEvent

Event onUpdate()
	if (self && self.isRunning())
		onStartUp()
		registerForSingleUpdate(NormalWait)
	endIf
endEvent

Function onStartUp()
	int kNPC = 43
	Actor player = Game.getPlayer()
	Cell playerCell = player.getParentCell()
	int i = playerCell.getNumRefs(kNPC)
	while (i > 0)
		i -= 1
		Actor target = playerCell.getNthRef(i, kNPC) as Actor
		if (target && (target != player || playerApplied) && target.isEnabled() && !target.isDead() && !target.isUnconscious() && target.hasKeyword(ActorTypeNPC))
			addObserverAbility(target)
		endIf
	endWhile
endFunction

Function addObserverAbility(Actor akTarget)
	int i = 0
	while (i < aaaObserverAbilityList.getSize())
		Spell s = aaaObserverAbilityList.getAt(i) as Spell
		MagicEffect me = s.GetNthEffectMagicEffect(0)
		if (s && !akTarget.hasMagicEffect(me))
			akTarget.removeSpell(s)
			akTarget.addSpell(s, false)
		endIf
		i += 1
	endWhile
endFunction
