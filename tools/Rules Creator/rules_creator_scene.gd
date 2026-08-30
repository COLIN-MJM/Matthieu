@tool
class_name Rules_Creator_Scene
extends Control
var rule_scene =preload("uid://c1toly1av552t")

@export var vContainer : VBoxContainer
@export var button : Button
@export var buttonEnd : Button


var filters:Array[Rule_scene]
func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	buttonEnd.pressed.connect(_on_end_pressed)

func _on_button_pressed():
	var instance = rule_scene.instantiate()
	vContainer.add_child(instance)	
	filters.append(instance)
	pass
func _on_end_pressed():
	var test:Array=[]
	for I_filters in filters :
		test.append_array(_Read_Filters(I_filters))
	print(test)
	var i = Rules_Formater .Receive_Unformated(test)
	print(i)


func _Read_Filters(rc:Rule_scene)->Array :
	var returnArray : Array
	returnArray.append(rc.filter_name)
	for arg in rc.arguments :
		if arg is Argument_scene :
			returnArray.append((arg as Argument_scene).argument)
		if arg is Rule_scene :
			returnArray.append_array(_Read_Filters((arg as Rule_scene)))
	if FilterBank.array_block_needed.has(rc.filter_name) : 
		returnArray.append(&"sequence_end")
	return returnArray
