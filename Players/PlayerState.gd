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
	if event.is_action_pressed("Left mouse Clic") and selectedSlot != null : 
		player.chosenSlot = selectedSlot
		player.stateMachine.ChangeToState(&"WaitingForConfirmation")
		return

func SelectCard(event: InputEvent) -> void :
	var selectedSlot := player.main_scene.currentHighlightedSlot
	if selectedSlot == null or selectedSlot.cardData == null : return
	if event.is_action_pressed("Left mouse Clic"): 
		player.chosenCard = selectedSlot.cardData
		match player.currentAction :
			&"Move" : player.stateMachine.ChangeToState(&"TargetingMove")
			&"Rotate" : player.stateMachine.ChangeToState(&"TargetingRotate")
			_: return
		return

func SelectHighlightableSlot(coord:Vector2i) -> void :
	var playspace := player.main_scene
	if playspace.allSlots.keys().has(coord): 
		playspace.highlightableSlots.append(playspace.allSlots[coord])
	return

func SelectNearbySlots(coord:Vector2i) -> void:
	SelectHighlightableSlot(Vector2i(coord.x + 1, coord.y))
	SelectHighlightableSlot(Vector2i(coord.x - 1, coord.y))
	SelectHighlightableSlot(Vector2i(coord.x, coord.y + 1))
	SelectHighlightableSlot(Vector2i(coord.x, coord.y - 1))

func SelectInfluencedSlots(p:bool) -> void:
	var playspace := player.main_scene
	playspace.highlightableSlots = playspace.allSlots.values().filter(
		func(x : CardSlot) : 
			var t1 = x.inT1control 
			var t2 = x.inT2control
			return (p and t1) or (!p and t2))
	return

func SelectOwnedCardSlot(p:bool) -> void:
	var playspace := player.main_scene
	playspace.highlightableSlots = playspace.allSlots.values().filter(
		func(x : CardSlot) : 
			var cd = x.cardData 
			if cd == null : return false
			return (p and cd.c_owner) or (!p and !cd.c_owner))
	return

func ToggleInteraction(up:bool) -> void:
	var playspace = player.main_scene
	playspace.interactionMode = up
	if playspace.currentHighlightedSlot != null :
		playspace.currentHighlightedSlot.Highlighted(false)
		playspace.currentHighlightedSlot = null
