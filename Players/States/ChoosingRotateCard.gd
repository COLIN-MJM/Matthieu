class_name ChoosingRotateCard
extends PlayerState

func OnEnter() -> void:
	player.currentAction = &"Rotate"
	indicativeText.add_text("Choose the concerned card")
	linkedButtons.visible = true
	player.main_scene.highlightableSlots.clear()
	SelectOwnedCardSlot(player.activePlayer)
	ToggleInteraction(true)
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	linkedButtons.visible = false
	indicativeText.clear()	
	ToggleInteraction(false)
	return

func _input(event: InputEvent) -> void :
	if player.currentState != self : return
	SelectCard(event)
