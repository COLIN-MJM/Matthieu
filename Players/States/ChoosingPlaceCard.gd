class_name ChoosingPlaceCard
extends PlayerState

func OnEnter() -> void:
	#Fait apparaître un texte d'indication ("Choisissez la carte concernée")
	#Fait apparaître l'UI de la main
	#Permet l'interaction à ladite UI
	#Fait apparaître un bouton Retour
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	#Fait disparaître le texte, la main et le bouton
	#Set currentAction à "Place"
	return
