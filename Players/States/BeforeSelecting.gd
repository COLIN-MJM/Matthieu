class_name BeforeSelecting
extends PlayerState

func OnEnter() -> void:
	#Fait apparaître un texte d'indication ("Player X, faites votre choix")
	#Set currentAction à "None"
	#Fait apparaître les trois boutons "Place", "Move" et "Rotate"
	#Grise "Place" si "PlacePlayedThisTurn" est true
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	#Fait disparaître le texte et les trois boutons
	return
