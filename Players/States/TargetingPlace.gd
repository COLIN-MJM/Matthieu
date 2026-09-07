class_name TargetingPlace
extends PlayerState

func OnEnter() -> void:
	#Place au centre de la "zone interface" un sprite de la carte choisie
	indicativeText.add_text("Choose the target tile to place it")
	#Highlight la zoc du joueur et permet l'interaction avec
	linkedButtons.visible = true
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	#Place le sprite de la carte à l'emplacement choisi
	indicativeText.clear()
	linkedButtons.visible = false
	return
