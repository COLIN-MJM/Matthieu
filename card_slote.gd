class_name  CardSlot
extends Node2D

var haveCarte : bool =false
var carte : CarteRenderer
var carteData : Carte 
var coords: Vector2i


func AssignCard(entrance : CarteRenderer)->void :
	entrance.position=Vector2(15,15)
	carte=entrance
	carteData=entrance.CardEffect
	carteData.position=coords
	haveCarte=true
	add_child(entrance)
func PlaceCard(entrance : CarteRenderer)->SecondaryEffect :
	AssignCard(entrance)
	if(entrance.CardEffect.ActivationType== GlobalCardEnum.ActivationTypes.OnPlacement) :
		return entrance.CardEffect.Activate()
	else :
		return
