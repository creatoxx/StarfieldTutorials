ScriptName GWI_PerkFragmentAP Extends Perk Const hidden

;shoutout to SKK50 for pioneering this stuff and sharing his compile/decompile.cmd!

Function Fragment_Entry_02(ObjectReference akTargetRef, Actor akActor)

	String ModName
	
	If Game.IsPluginInstalled("GWI_GeneralWorldInteractor.esm") == 1 as Bool
		ModName = "GWI_GeneralWorldInteractor.esm"
	EndIf
	
	If ModName == ""
		Debug.MessageBox("ScriptFragment not found! Consult the Creator.")
		Return
	EndIf
	
	GWI_QuestScript QuestScript = Game.GetFormFromFile(2090, ModName) as GWI_QuestScript; this has to be ID: 82A or the 2090 isn't correct
	
	If !QuestScript
		Debug.MessageBox("Quest Script not found! Consult the Creator.")
		Return
	EndIf
	QuestScript.InteractWorld(akTargetRef, akActor)
	
EndFunction
