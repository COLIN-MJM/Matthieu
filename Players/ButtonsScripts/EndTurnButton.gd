class_name EndTurnButton
extends PlayerButton

func onButtonPressed() -> void:
	var player = linkedState.player
	player.stateMachine.ChangeToState(&"NotPlaying")
	return
