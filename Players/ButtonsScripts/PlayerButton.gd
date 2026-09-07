@abstract
class_name PlayerButton
extends Button

@export var linkedState : PlayerState

func _ready() -> void:
	self.pressed.connect(onButtonPressed)

@abstract func onButtonPressed() -> void
