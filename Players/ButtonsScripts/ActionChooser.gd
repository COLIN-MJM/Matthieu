class_name ActionChooser
extends PlayerButton

@export var linkedAction : StringName

func onButtonPressed() -> void:
	linkedState.player.stateMachine.ChangeToState(linkedAction)
	return
