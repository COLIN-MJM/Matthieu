class_name WaitingForConfirmation
extends PlayerState

func OnEnter() -> void:
	#Fait apparaître un texte d'indication ("Êtes-vous sûr?")
	#Fait apparaître un bouton Confirmer et un bouton Retour
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	#Fait disparaître tout ce qu'il a fait apparaître
	#Augmente de 1 la valeur de "nbActionsPlayedThisTurn" sur Player
	#Trigger le bool "PlacePlayedThisTurn" à true si currentAction est "Place"
	return
