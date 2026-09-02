class_name NewPlayer
extends Control

@export var identity : bool
@export var otherPlayer : NewPlayer

var nbActionsPlayedThisTurn : int = 0
var PlacePlayedThisTurn : bool = false

@export var states : Dictionary[StringName, PlayerState]
var currentState : PlayerState = null

func _ready() -> void:
	currentState = states[&"NotPlaying"]
	print(currentState)
