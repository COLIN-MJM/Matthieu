class_name ChoosingRotateCard
extends PlayerState

func OnEnter() -> void:
	#Fait apparaître un texte d'indication ("Choisissez la carte concernée")
	#Permet des feedbacks à l'hover du Playspace
	#Fait apparaître un bouton Retour
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	#Fait disparaître le texte et le bouton
	#Désactive les feedbacks du Playspace
	#Set currentAction à "Rotate"
	return
