class_name ChoosingPlaceCard
extends PlayerState

func OnEnter() -> void:
	indicativeText.add_text("Choose the concerned card")
	linkedButtons.visible = true
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	linkedButtons.visible = false
	indicativeText.clear()
	player.currentAction = &"Place"
	return
