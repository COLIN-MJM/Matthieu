class_name NotPlaying
extends PlayerState

func OnEnter() -> void:
	player.nbActionsPlayedThisTurn = 0
	player.PlacePlayedThisTurn = false
	player.otherPlayer.stateMachine.ChangeToState(&"BeforeSelecting")
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	#Rien
	return
