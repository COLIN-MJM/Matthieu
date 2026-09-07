class_name EvaluatingEndTurn
extends PlayerState

func OnEnter() -> void:
	if player.nbActionsPlayedThisTurn == player.maxNbActions :
		player.stateMachine.ChangeToState(&"NotPlaying")
	else :
		indicativeText.add_text("Do you want to continue your turn? Max" + str(player.maxNbActions - player.nbActionsPlayedThisTurn) + " action(s) remaining")
		linkedButtons.visible = true
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	indicativeText.clear()
	linkedButtons.visible = false
	return
