class_name Hand
extends Node

@export var player : NewPlayer
@export var cardButtonsInHand : Array[CardButton]
@export var previousButton : Button
@export var nextButton : Button
var offset : int = 0

func UpdateCardsInHand(owner:bool) -> void:
	if offset == 0 : previousButton.visible = false
	else : previousButton.visible = true
	
	if owner : RunThroughDeckToUpdate(player.remainingDeckP1)
	else : RunThroughDeckToUpdate(player.remainingDeckP2)
	return

func RunThroughDeckToUpdate(deck:Array[Card]) -> void:
	for i in range(0, 5):
		var card = cardButtonsInHand[i]
		if deck.size() <= offset + i : 
			card.visible = false
		else :
			card.visible = true
			card.linkedCard = deck[offset + i]
			card.text = card.linkedCard.rule.rule_name
		if i == 4 and deck.size() <= offset + i + 1 : nextButton.visible = false
		else : nextButton.visible = true
	return
