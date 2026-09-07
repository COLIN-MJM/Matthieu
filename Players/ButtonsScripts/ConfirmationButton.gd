class_name ConfirmationButton
extends PlayerButton

@export var isConfirming : bool

func onButtonPressed() -> void:
	match linkedState.player.currentAction :
		&"Move" : 
			if isConfirming :
				#Active l'appel de mouvement
				linkedState.player.stateMachine.ChangeToState(&"EvaluatingEndTurn")
				linkedState.player.nbActionsPlayedThisTurn += 1
			else :
				linkedState.player.stateMachine.ChangeToState(&"TargetingMove")
		&"Rotate" :
			if isConfirming :
				#Active l'appel de rotation
				linkedState.player.stateMachine.ChangeToState(&"EvaluatingEndTurn")
				linkedState.player.nbActionsPlayedThisTurn += 1
			else :
				linkedState.player.stateMachine.ChangeToState(&"TargetingRotate")
		&"Place" : 
			if isConfirming :
				#Active l'appel de placement
				linkedState.player.stateMachine.ChangeToState(&"EvaluatingEndTurn")
				linkedState.player.PlacePlayedThisTurn = true
				linkedState.player.nbActionsPlayedThisTurn += 1
			else :
				linkedState.player.stateMachine.ChangeToState(&"TargetingPlace")
		_ : return
	return
