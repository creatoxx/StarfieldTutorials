ScriptName GWI_QuestScript Extends Quest

;shoutout to SKK50 for pioneering this stuff and sharing his compile/decompile.cmd!

Actor Property PlayerRef Auto Const mandatory
Perk Property DoorInteractionPerk Auto Const mandatory
Perk Property GlobalInteractionPerk Auto Const mandatory

Event OnQuestInit()
	Self.AddInteractPerk()
EndEvent

Event Actor.OnPlayerLoadGame(Actor akSender)
	Self.AddInteractPerk()
EndEvent

Function AddInteractPerk()
	If !PlayerRef.HasPerk(GlobalInteractionPerk)
		PlayerRef.AddPerk(DoorInteractionPerk, False)	
		PlayerRef.AddPerk(GlobalInteractionPerk, False)		
	EndIf
EndFunction

Function InteractWorld(ObjectReference akTargetRef, Actor akActor)	
	If akTargetRef && akTargetRef as Actor
		Actor actorTarget = akTargetRef as Actor	
		actorTarget.OpenInventory(true, none, false)
		;actorTarget.ShowBarterMenu()
	EndIf
EndFunction

Function InteractDoor(ObjectReference akTargetRef, Actor akActor)
	Debug.Notification("Try to lock!")	
	If akTargetRef
		akTargetRef.Lock(true, false, false)
	EndIf
EndFunction