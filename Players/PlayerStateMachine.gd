class_name PlayerStateMachine
extends Node

@export var player : NewPlayer

func _process(float) -> void :
	player.currentState.OnUpdate()

func ChangeToState(state:StringName) -> void :
	if player.currentState != null :
		player.currentState.OnExit()
	player.currentState = player.states[state]
	player.currentState.OnEnter()
	return
