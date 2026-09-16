class_name ChoosingPlaceCard
extends PlayerState

@export var chooseButton : Button
@export var hand : Hand

func OnEnter() -> void:
	indicativeText.add_text("Choose the concerned card")
	linkedButtons.visible = true
	chooseButton.visible = false
	hand.offset = 0
	hand.UpdateCardsInHand(player.activePlayer)
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	linkedButtons.visible = false
	indicativeText.clear()
	player.currentAction = &"Place"
	return
