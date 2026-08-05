class_name Player
extends Control


@export var main : La_Main
var playSpace: PlaySpace

var cur_selected_index : int = -1
func _input(event: InputEvent) -> void:
	create_card_from_clic(event)

func create_card_from_clic(event : InputEvent)->void :
	##Check if initial condition are proper
	if event is not InputEventMouseButton:
		return
	if  cur_selected_index == -1 :
		cur_selected_index = main.currentSelected
		return
	var carte : Carte = main.requestCard(cur_selected_index)
	if carte == null :
		return
	
	print("passed initial test")
	
	##create position and check validity
	var mousePos : Vector2= event.global_position
	var test : Vector2i = Vector2i( floori(mousePos.x /playSpace.slotSize.x) ,floori(mousePos.y /playSpace.slotSize.y))
	print("test is " ,test)
	if test.x >playSpace.dimensions.x or test.x <0 or test.y >playSpace.dimensions.y or test.y <0  :
		return
	print("passed position test  value is ",test)
	##create the card
	var ressource : PackedScene = preload("res://CarteInstance.tscn")
	var instance : CarteRenderer =ressource.instantiate()
	instance.CardEffect=carte
	playSpace.allSlots[test].AssignCard(instance)
