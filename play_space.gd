extends Node2D
@export var dimensions : Vector2i
@export var slotSize : Vector2i

@onready var carteSlot : PackedScene =$".".get_meta("CarteSlot")

var allSlots :Dictionary[Vector2i,CardSlot]

func _ready() -> void:
	createGrid()
	debugCreateCard(Vector2i(2,2))

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
	
