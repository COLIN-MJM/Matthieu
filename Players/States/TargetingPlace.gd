class_name TargetingPlace
extends PlayerState

func OnEnter() -> void:
	#Place au centre de la "zone interface" un sprite de la carte choisie
	#Fait apparaître un texte d'indication ("Choisissez où placer cette carte")
	#Highlight la zoc du joueur et permet l'interaction avec
	#Fait apparaitre un bouton Retour
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	#Place le sprite de la carte à l'emplacement choisi
	#Fait disparaître tout le reste de ce qui est apparu ici
	return
