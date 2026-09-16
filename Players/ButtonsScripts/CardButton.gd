class_name CardButton
extends PlayerButton

var linkedCard : Card
@export var chooseButton : Button

func onButtonPressed() -> void: 
	linkedState.player.chosenCardToPlace = linkedCard
	chooseButton.visible = true
	return
