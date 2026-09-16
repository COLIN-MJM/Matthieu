class_name ConfirmationButton
extends PlayerButton

@export var isConfirming : bool

func onButtonPressed() -> void:
	var player = linkedState.player
	match player.currentAction :
		&"Move" : 
			if isConfirming :
				OnMove()
				linkedState.player.stateMachine.ChangeToState(&"EvaluatingEndTurn")
				linkedState.player.nbActionsPlayedThisTurn += 1
			else :
				linkedState.player.stateMachine.ChangeToState(&"TargetingMove")
		&"Rotate" :
			if isConfirming :
				OnRotate()
				linkedState.player.stateMachine.ChangeToState(&"EvaluatingEndTurn")
				linkedState.player.nbActionsPlayedThisTurn += 1
			else :
				linkedState.player.stateMachine.ChangeToState(&"TargetingRotate")
		&"Place" : 
			if isConfirming :
				OnPlace()
				player.stateMachine.ChangeToState(&"EvaluatingEndTurn")
				player.PlacePlayedThisTurn = true
				player.nbActionsPlayedThisTurn += 1
				if player.activePlayer : 
					player.remainingDeckP1 = DeckAfterRemovedCard(player.chosenCardToPlace, player.remainingDeckP1)
				else :
					player.remainingDeckP2 = DeckAfterRemovedCard(player.chosenCardToPlace, player.remainingDeckP2)
			else :
				player.stateMachine.ChangeToState(&"TargetingPlace")
		_ : return
	return

func DeckAfterRemovedCard(card:Card, deck:Array[Card]) -> Array[Card] :
	var newDeck : Array[Card]
	for c in deck :
		if c != card : newDeck.append(c)
	return newDeck

func OnMove() -> void:
	var player = linkedState.player
	GameStateManager.MoveCard(player.chosenCard, player.chosenSlot.coords)
	return
	
func OnRotate() -> void:
	return
	
func OnPlace() -> void:
	var player = linkedState.player
	GameStateManager.PlaceCard(player.chosenCardToPlace, player.chosenSlot.coords)
	return
