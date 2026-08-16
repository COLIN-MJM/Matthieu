class_name  CardSlot
extends Node2D

var haveCarte : bool =false
var carte : CarteRenderer
var carteData : Carte 
var coords: Vector2i
@export var poly : Polygon2D

func AssignCard(entrance : CarteRenderer)->void :
	carte=entrance
	carteData=entrance.CardEffect
	carteData.position=coords
	haveCarte=true
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
	print(carteData.direction)
	if carteData.ActivationType ==GlobalCardEnum.ActivationTypes.OnRotate :
		return carteData.Activate()
	else :
		return
func ActivateCard()->SecondaryEffect:
	return carteData.Activate()
