class_name TargetingMove
extends PlayerState

func OnEnter() -> void:
	indicativeText.add_text("Choose its destination tile")
	linkedButtons.visible = true
	var playspace := player.main_scene
	playspace.highlightableSlots.clear()
	SelectNearbySlots(player.chosenCard.c_position)
	ToggleInteraction(true)
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	#Place le sprite de la carte à l'emplacement choisi
	indicativeText.clear()
	linkedButtons.visible = false
	ToggleInteraction(false)
	return

func _input(event: InputEvent) -> void:
	if player.currentState != self : return
	SelectSlot(event)
