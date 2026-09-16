class_name NextPreviousButton
extends PlayerButton

@export var offsetGiven : int
@export var hand : Hand

func onButtonPressed() -> void: 
	hand.offset += offsetGiven
	hand.UpdateCardsInHand(linkedState.player.activePlayer)
	return
