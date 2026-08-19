class_name  CardSlot
extends Node2D

var haveCarte : bool =false
var carte : CarteRenderer
var carteData : Carte 
var coords: Vector2i
var combat_score : int
@export var poly : Polygon2D

func AssignCard(entrance : CarteRenderer)->void :
	carte=entrance
	carteData=entrance.CardEffect
	carteData.position=coords
	haveCarte=true
	entrance.process_card_rotate()
	add_child(entrance)
func PlaceCard(entrance : CarteRenderer)->SecondaryEffect :
	AssignCard(entrance)
	if entrance.CardEffect.ActivationType== GlobalCardEnum.ActivationTypes.OnPlacement :
		return entrance.CardEffect.Activate()
	else :
		return
func ReceiveMovedCard(entrance : CarteRenderer)->SecondaryEffect :
	AssignCard(entrance)
	if entrance.CardEffect.ActivationType== GlobalCardEnum.ActivationTypes.OnMove :
		return entrance.CardEffect.Activate()
	else :
		return
func GiveMovedCard()->CarteRenderer:
	haveCarte=false
	remove_child(carte)
	var give : CarteRenderer = carte
	carte = null
	carteData = null
	return give
func RotateCard(rotationFunc : Callable)->SecondaryEffect :
	
	rotationFunc.call(carteData)
	carte.process_card_rotate()
	if carteData.ActivationType ==GlobalCardEnum.ActivationTypes.OnRotate :
		return carteData.Activate()
	else :
		return
func ActivateCard()->SecondaryEffect:
	if carteData.ActivationType ==GlobalCardEnum.ActivationTypes.OnRotate :
		carte.process_card_rotate()
	return carteData.Activate()
func KillCard()->SecondaryEffect :
	var playspace =get_node("/root/Node2D") as PlaySpace
	var card_owner :Player =(playspace.player_manager.players[carteData.owner] as Player)
	card_owner.main.allCarteState[carteData.cardNumber]=La_Main.CarteState.IN_CEMETARY
	card_owner.main.carteCemetary.get_or_add(carteData.cardNumber,card_owner.main.deathCD)
	haveCarte=false
	carte.free()
	carte=null
	carteData=null
	return null
