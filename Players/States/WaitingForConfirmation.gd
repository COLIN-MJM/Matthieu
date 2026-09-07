class_name WaitingForConfirmation
extends PlayerState

func OnEnter() -> void:
	indicativeText.add_text("Are you sure?")
	linkedButtons.visible = true
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	indicativeText.clear()
	linkedButtons.visible = false
	return
