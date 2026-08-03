extends Node2D
@export var dimensions : Vector2i
@export var slotSize : Vector2i

@onready var carteSlot : PackedScene =$".".get_meta("CarteSlot")
@onready var hand : PackedScene =$".".get_meta("Hand")

var main : La_Main


var allSlots :Dictionary[Vector2i,CardSlot]

func _ready() -> void:
	createGrid()
	createHand()

var cur_selected_index : int = -1
func _input(event: InputEvent) -> void:
	create_card_from_clic(event)

func createHand()->void:
	main = hand.instantiate()
	add_child(main)

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
	var test : Vector2i = Vector2i( floori(mousePos.x /slotSize.x) ,floori(mousePos.y /slotSize.y))
	print("test is " ,test)
	if test.x >dimensions.x or test.x <0 or test.y >dimensions.y or test.y <0  :
		return
	print("passed position test  value is ",test)
	##create the card
	var ressource : PackedScene = preload("res://CarteInstance.tscn")
	var instance : CarteRenderer =ressource.instantiate()
	instance.CardEffect=carte
	allSlots[test].AssignCard(instance)


func createGrid()->void:
	for y in dimensions.y :
		for x in dimensions.x :
			var instance : CardSlot = carteSlot.instantiate()
			instance.position =position+ Vector2(slotSize.x *x,slotSize.y * y )
			instance.coords=Vector2i(x,y)
			allSlots[Vector2i(x,y)]= instance
			add_child(instance)

func debugCreateCard(at :Vector2i =Vector2i(0,0))->void :
	var ressource : PackedScene = preload("res://CarteInstance.tscn")
	var instance : CarteRenderer =ressource.instantiate()
	instance.CardEffect.direction=Vector2i.RIGHT
	allSlots[at].AssignCard(instance)
	
