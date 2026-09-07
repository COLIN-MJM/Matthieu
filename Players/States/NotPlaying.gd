class_name NotPlaying
extends PlayerState

func OnEnter() -> void:
	player.nbActionsPlayedThisTurn = 0
	player.PlacePlayedThisTurn = false
	player.activePlayer = !player.activePlayer
	player.stateMachine.ChangeToState(&"BeforeSelecting")
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	if player.activePlayer : player.playerName = &"Player 1"
	else : player.playerName = &"Player 2"
	return
