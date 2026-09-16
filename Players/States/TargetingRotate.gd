class_name TargetingRotate
extends PlayerState

func OnEnter() -> void:
	indicativeText.add_text("Choose in which direction you want it to face")
	var playspace := player.main_scene
	playspace.highlightableSlots.clear()
	SelectNearbySlots(player.chosenCard.c_position)
	ToggleInteraction(true)
	linkedButtons.visible = true
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	#Tourne le sprite de la carte dans le sens choisi
	indicativeText.clear()
	linkedButtons.visible = false
	ToggleInteraction(false)
	return

func _input(event: InputEvent) -> void:
	if player.currentState != self : return
	SelectSlot(event)
