class_name ChoosingRotateCard
extends PlayerState

func OnEnter() -> void:
	indicativeText.add_text("Choose the concerned card")
	linkedButtons.visible = true
	#Permet des feedbacks à l'hover du Playspace
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	linkedButtons.visible = false
	indicativeText.clear()
	player.currentAction = &"Rotate"
	#Désactive les feedbacks du Playspace
	return
