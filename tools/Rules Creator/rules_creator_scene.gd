@tool
class_name Rules_Creator_Scene
extends MarginContainer

@onready var distance: Button = %Distance
var distance_pressed : Callable = _on_button_pressed.bind(0)
@onready var direction: Button = %Direction
var direction_pressed : Callable = _on_button_pressed.bind(1)
signal confirmed(text : String)

func _ready() -> void:
	distance.pressed.connect(distance_pressed)
	direction.pressed.connect(direction_pressed)

func _on_button_pressed(index:int):
	match index:
		0: confirmed.emit("Distance")
		1: confirmed.emit("Direction")
