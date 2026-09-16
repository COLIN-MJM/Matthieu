@abstract
class_name PlayerState
extends Node

@export var player : NewPlayer
@export var linkedButtons : Control
@export var indicativeText : RichTextLabel

@abstract func OnEnter() -> void
@abstract func OnUpdate() -> void
@abstract func OnExit() -> void

func SelectSlot(event: InputEvent) -> void :
	var selectedSlot := player.main_scene.currentHighlightedSlot
	if event.is_action_pressed("Left Mouse Clic") and selectedSlot != null : 
		player.chosenSlot = selectedSlot
		player.stateMachine.ChangeToState(&"WaitingForConfirmation")
		return

func SelectCard(event: InputEvent) -> void :
	var selectedSlot := player.main_scene.currentHighlightedSlot
	if selectedSlot.cardData == null : return
	if event.is_action_pressed("Left Mouse Clic") and selectedSlot != null : 
		player.chosenCard = selectedSlot.cardData
		match player.currentAction :
			&"Move" : player.stateMachine.ChangeToState(&"TargetingMove")
			&"Rotate" : player.stateMachine.ChangeToState(&"TargetingRotate")
			_: return
		return
