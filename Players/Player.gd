class_name NewPlayer
extends Control

var activePlayer : bool = true
var playerName : StringName

var nbActionsPlayedThisTurn : int = 0
var maxNbActions : int = 3
var PlacePlayedThisTurn : bool = false

@export var states : Dictionary[StringName, PlayerState]
@export var stateMachine : PlayerStateMachine
var currentState : PlayerState 
var currentAction : StringName

func _ready() -> void:
	currentState = states[&"NotPlaying"]
	playerName = &"Player 1"
	stateMachine.ChangeToState(&"BeforeSelecting")
