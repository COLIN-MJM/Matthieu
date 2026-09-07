class_name BeforeSelecting
extends PlayerState

func OnEnter() -> void:
	indicativeText.add_text(player.playerName + ", choose an action to play")
	player.currentAction = "None"
	linkedButtons.visible = true
	#Grise "Place" si "PlacePlayedThisTurn" est true
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	indicativeText.clear()
	linkedButtons.visible = false
	return
