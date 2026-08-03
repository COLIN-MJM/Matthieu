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
	print_debug(carteData)
	carteData.position=coords
	haveCarte=true
	add_child(entrance)
	print(carteData.position,carteData.ActivationType)
