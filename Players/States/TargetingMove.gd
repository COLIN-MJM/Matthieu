class_name TargetingMove
extends PlayerState

func OnEnter() -> void:
	indicativeText.add_text("Choose its destination tile")
	linkedButtons.visible = true
	#Highlight les cases accessibles et permet l'interaction avec
	#Fait apparaitre un bouton Retour
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	#Place le sprite de la carte à l'emplacement choisi
	indicativeText.clear()
	linkedButtons.visible = false
	return
