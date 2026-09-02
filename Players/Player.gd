class_name NewPlayer
extends Control

@onready var state_machine: PlayerStateMachine = %StateMachine

@export var states : Dictionary[StringName, PlayerState]
var currentState : PlayerState = null

func _ready() -> void:
	state_machine.player = self
	currentState = states[&"NotPlaying"]
	print(currentState)
