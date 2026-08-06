class_name Player
extends Control


@export var main : La_Main
var playSpace: PlaySpace

var cur_selected_index : int = -1
func _input(event: InputEvent) -> void:
	if create_card_from_clic(event) : return
	if move_card_from_clic(event):return ##c'est dégeu mais il attribue save pos pour plus tard
	if rotate_card_from_clic(event) : return
	playSpace.sideEffectHandler.ResolveSecondaryEffects()
func create_card_from_clic(event : InputEvent)->bool :
	##Check if initial condition are proper
	if event is not InputEventMouseButton:
		return false
	if !event.is_action_pressed("Left mouse Clic") :return false
	if  cur_selected_index == -1 :
		cur_selected_index = main.currentSelected
		return false
	var carte : Carte = main.requestCard(cur_selected_index)
	if carte == null :
		return false
	
	
	
	##create position and check validity
	var pos=  verrify_Clic_position(event)
	if pos ==Vector2i(-1,-1) :return false
	##create the card
	var ressource : PackedScene = preload("res://CarteInstance.tscn")
	var instance : CarteRenderer =ressource.instantiate()
	instance.CardEffect=carte
	var effects:SecondaryEffect = playSpace.allSlots[pos].PlaceCard(instance)
	if effects !=null:
		playSpace.sideEffectHandler.queu_secondaryEffect(effects)
	cur_selected_index=-1
	return true

var savedpos : Vector2i=Vector2i(-1,-1)
func move_card_from_clic(event : InputEvent)->bool :
	##Check if initial condition are proper
	if event is not InputEventMouseButton:
		return false
	if !event.is_action_pressed("Left mouse Clic") :return false

	if savedpos==Vector2i(-1,-1) :
		savedpos=  verrify_Clic_position(event)
		if savedpos ==Vector2i(-1,-1) :return false
		if !playSpace.allSlots[savedpos].haveCarte : 
			savedpos=Vector2i(-1,-1)
			return false
	##create position and check validity
	var newPos=verrify_Clic_position(event)
	if newPos ==Vector2i(-1,-1) :return false
	if newPos.distance_to(savedpos)!=1:return false
	if playSpace.allSlots[newPos].haveCarte : return false
	var cardrendered = playSpace.allSlots[savedpos].GiveMovedCard()
	var effects:SecondaryEffect = playSpace.allSlots[newPos].ReceiveMovedCard(cardrendered)
	if effects !=null:
		playSpace.sideEffectHandler.queu_secondaryEffect(effects)
	savedpos=Vector2i(-1,-1)
	newPos =Vector2i(-1,-1)
	return true

func rotate_card_from_clic(event : InputEvent)->bool :
	##Check if initial condition are proper
	if savedpos == Vector2i(-1,-1) : return false
	if !event.is_action_pressed("Right mous Clic") : return false
	var newPos=verrify_Clic_position(event)
	if newPos ==Vector2i(-1,-1) :return false
	if newPos.distance_to(savedpos)!=1:return false
	var newDir : Vector2i = newPos-savedpos
	var rotatFunc : Callable = func(x : Carte) : x.direction= newDir
	var effects:SecondaryEffect = playSpace.allSlots[savedpos].RotateCard(rotatFunc)
	if effects !=null:
		playSpace.sideEffectHandler.queu_secondaryEffect(effects)
	return true

func verrify_Clic_position(event : InputEvent )->Vector2i :
	var mousePos : Vector2= event.global_position
	var test : Vector2i = Vector2i( floori(mousePos.x /playSpace.slotSize.x) ,floori(mousePos.y /playSpace.slotSize.y))
	if test.x >playSpace.dimensions.x or test.x <0 or test.y >playSpace.dimensions.y or test.y <0  :
		return Vector2i(-1,-1)
	return test
