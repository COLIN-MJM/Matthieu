class_name NewPlayer
extends Control

@export var identity : bool
@export var otherPlayer : NewPlayer
var playerName : StringName

var nbActionsPlayedThisTurn : int = 0
var maxNbActions : int = 3
var PlacePlayedThisTurn : bool = false

@export var states : Dictionary[StringName, PlayerState]
@export var stateMachine : PlayerStateMachine
var currentState : PlayerState = null
var currentAction : StringName

func _ready() -> void:
	if identity : playerName = &"Player 1"
	else : playerName = &"Player 2"
	stateMachine.ChangeToState(&"BeforeSelecting")
