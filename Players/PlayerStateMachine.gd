class_name PlayerStateMachine
extends Node

var player : NewPlayer

func _process(float) -> void :
	player.currentState.OnUpdate()

func ChangeToState(state:PlayerState) -> void :
	if player.currentState != null :
		player.currentState.OnExit()
	player.currentState = state
	player.currentState.OnEnter()
	return
