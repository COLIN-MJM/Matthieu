class_name ChoosingRotateCard
extends PlayerState

func OnEnter() -> void:
	indicativeText.add_text("Choose the concerned card")
	linkedButtons.visible = true
	player.main_scene.interactionMode = true
	player.main_scene.currentHighlightedSlot = null
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	linkedButtons.visible = false
	indicativeText.clear()
	player.currentAction = &"Rotate"
	player.main_scene.currentHighlightedSlot = null
	player.main_scene.interactionMode = false
	return
