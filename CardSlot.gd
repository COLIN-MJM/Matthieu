class_name  CardSlot
extends Node2D

var haveCard : bool = false
var carte : CardRenderer
var cardData : Card 
var coords: Vector2i
var combat_score : int
@export var poly : Polygon2D

func AssignCard(entrance : CardRenderer)->void :
	carte=entrance
	cardData=entrance.CardEffect
	cardData.position=coords
	haveCard=true
	entrance.process_card_rotate()
	add_child(entrance)

func PlaceCard(entrance : CardRenderer)->SecondaryEffect :
	AssignCard(entrance)
	if entrance.CardEffect.ActivationType== GlobalCardEnum.ActivationTypes.OnPlacement :
		return entrance.CardEffect.Activate()
	else :
		return

func ReceiveMovedCard(entrance : CardRenderer)->SecondaryEffect :
	AssignCard(entrance)
	if entrance.CardEffect.ActivationType== GlobalCardEnum.ActivationTypes.OnMove :
		return entrance.CardEffect.Activate()
	else :
		return

func GiveMovedCard()->CardRenderer:
	haveCard=false
	remove_child(carte)
	var give : CardRenderer = carte
	carte = null
	cardData = null
	return give

func RotateCard(rotationFunc : Callable)->SecondaryEffect :
	rotationFunc.call(cardData)
	carte.process_card_rotate()
	if cardData.ActivationType ==GlobalCardEnum.ActivationTypes.OnRotate :
		return cardData.Activate()
	else :
		return

func ActivateCard()->SecondaryEffect:
	if cardData.ActivationType ==GlobalCardEnum.ActivationTypes.OnRotate :
		carte.process_card_rotate()
	return cardData.Activate()

func KillCard()->SecondaryEffect :
	var playspace =get_node("/root/Node2D") as PlaySpace
	var card_owner :Player =(playspace.player_manager.players[cardData.owner] as Player)
	card_owner.main.allCarteState[cardData.cardNumber]=La_Main.CarteState.IN_CEMETARY
	card_owner.main.carteCemetary.get_or_add(cardData.cardNumber,card_owner.main.deathCD)
	haveCard=false
	carte.free()
	carte=null
	cardData=null
	return null
