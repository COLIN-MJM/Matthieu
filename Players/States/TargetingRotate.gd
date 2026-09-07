class_name TargetingRotate
extends PlayerState

func OnEnter() -> void:
	indicativeText.add_text("Choose in which direction you want it to face")
	#Highlight les 4 cases autour et permet l'interaction avec
	linkedButtons.visible = true
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	#Tourne le sprite de la carte dans le sens choisi
	indicativeText.clear()
	linkedButtons.visible = false
	return
