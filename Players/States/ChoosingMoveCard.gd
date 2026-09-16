class_name ChoosingMoveCard
extends PlayerState

func OnEnter() -> void:
	player.currentAction = &"Move"
	indicativeText.add_text("Choose the concerned card")
	linkedButtons.visible = true
	player.main_scene.highlightableSlots.clear()
	SelectOwnedCardSlot(player.activePlayer)
	ToggleInteraction(true)
	return

func OnUpdate() -> void:
	var slot := player.main_scene.currentHighlightedSlot
	if slot == null : return
	if (slot.cardData == null) : return
	print(slot.cardData)
	return

func OnExit() -> void:
	linkedButtons.visible = false
	indicativeText.clear()
	ToggleInteraction(false)
	return

func _input(event: InputEvent) -> void :
	if player.currentState != self : return
	SelectCard(event)
