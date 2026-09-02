class_name EvaluatingEndTurn
extends PlayerState

func OnEnter() -> void:
	#Si nbActionsPlayedThisTurn == maxNbActions :
		#Exit immédiatement
	#Sinon :
		#Fait apparaître un texte d'indication ("Voulez-vous continuer? (x actions restantes)")
		#Fait apparaître un bouton Continuer et un bouton Passer
	return

func OnUpdate() -> void:
	#Rien
	return

func OnExit() -> void:
	#Fait disparaître tout ce qu'il a fait apparaître
	return
