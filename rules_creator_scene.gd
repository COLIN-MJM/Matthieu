@tool
extends MarginContainer

@onready var distance: Button = %Distance
@onready var direction: Button = %Direction

signal confirmed(text : String)

func _ready() -> void:
	distance.pressed.connect(_on_button_pressed(0))
	direction.pressed.connect(_on_button_pressed(1))

func _on_button_pressed(index:int):
	match index:
		0: confirmed.emit("Distance")
		1: confirmed.emit("Direction")
