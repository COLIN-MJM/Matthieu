class_name Player
extends Control

var player_Id : int
@export var main : La_Main
var playSpace: PlaySpace
signal  turnSuccessFull 
var isTurn: bool = false :
	get : 
		return isTurn
	set(value) : 
		if value ==true :
			main.allCarte.visible=true
			set_process_input(true)
		else : 
			main.allCarte.visible=false
			set_process_input(false)
		isTurn=value
var cur_PState : Player_State = Gui_none_selected.new(self)




func _setup_listVisual() :
	if sign(player_Id)==-1 :
		main.allCarte.position = Vector2(0+(main.allCarte.size.x+15)*((player_Id+1)*-1),0)
	else :
		main.allCarte.position = Vector2((get_window().size.x-main.allCarte.size.x)+(main.allCarte.size.x+15)*((player_Id-1)*-1),0)
var cur_selected_index : int = -1
func _input(event: InputEvent) -> void:
	if !isTurn : return
	if event.is_echo() :return
	
	if main.currentSelected != -1 : 
		cur_PState=Gui_selected.new(self,main.currentSelected)
		main.currentSelected=-1
	var nextState : Player_State = cur_PState.process_event(event)
	if  nextState!=null : cur_PState= nextState

func _on_turn_success_full() -> void:
	cur_PState=Gui_none_selected.new(self)





func verrify_Clic_position(event : InputEvent )->Vector2i :
	var mousePos : Vector2= event.global_position
	var tlmidbr: PackedVector2Array=playSpace.TlMidBr
	if mousePos.x < tlmidbr[0].x or mousePos.x > tlmidbr[2].x or mousePos.y < tlmidbr[0].y or mousePos.y > tlmidbr[2].y:
		return Vector2i(-1,-1)
	mousePos = mousePos-tlmidbr[0]

	var test : Vector2i = Vector2i( floori(mousePos.x /playSpace.slotSize.x) ,floori(mousePos.y /playSpace.slotSize.y))
	if test.x >playSpace.dimensions.x or test.x <0 or test.y >playSpace.dimensions.y or test.y <0  :
		return Vector2i(-1,-1)
	return test
#region Player_States

@abstract class Player_State :
	var  player :Player
	func _init(p : Player) -> void:
		player=p
	@abstract func process_event(ie:InputEvent)->Player_State
class Gui_none_selected :
	extends Player_State
	func process_event(event : InputEvent)->Player_State:
		
		if event is not InputEventMouseButton : return null
		var pos=  player.verrify_Clic_position(event)
		if pos ==Vector2i(-1,-1) :return null
		if !player.playSpace.allSlots[pos].haveCarte or sign(player.playSpace.allSlots[pos].carteData.owner)!=sign(player.player_Id)  :
			return null
		if event.is_action_pressed("Left mouse Clic") :
			return Card_Selected.new(player,player.playSpace.allSlots[pos])
		if event.is_action_pressed("Right mous Clic") :
			if activate_card_from_clic(pos) : player.turnSuccessFull.emit()
		return null
	func activate_card_from_clic(pos: Vector2i)->bool :
		if player.playSpace.allSlots[pos].carteData.ActivationType != GlobalCardEnum.ActivationTypes.OnPlayerActivation : return false
		var effects : SecondaryEffect = player.playSpace.allSlots[pos].ActivateCard()
		if effects != null : player.playSpace.sideEffectHandler.queu_secondaryEffect(effects)
		return true


class Gui_selected :
	extends Player_State
	var cur_hand_index : int
	func _init(p : Player,chi : int ) -> void:
		super(p)
		cur_hand_index=chi
	func process_event(event : InputEvent)->Player_State:
		if event.is_action_pressed("Left mouse Clic") :
			if create_card_from_clic(event) : player.turnSuccessFull.emit()
		return null
	func create_card_from_clic(event : InputEvent)->bool :
		var pos= player.verrify_Clic_position(event)
		if pos ==Vector2i(-1,-1) :return false
		if player.playSpace.allSlots[pos].haveCarte :
			if sign(player.playSpace.allSlots[pos].carteData.owner)!=sign(player.player_Id) and sign(player.playSpace.allSlots[pos].combat_score)!=sign(player.player_Id) : 
				return false
			player.playSpace.allSlots[pos].KillCard()
		var carte : Carte = player.main.requestCard(cur_hand_index)
		if carte == null :
			return false
		##create the card
		carte.owner=player.player_Id
		carte.strenght=sign(player.player_Id)
		var ressource : PackedScene = preload("res://CarteInstance.tscn")
		var instance : CarteRenderer =ressource.instantiate()
		instance.spriteMain.scale=player.playSpace.scaler
		instance.CardEffect=carte
		var effects:SecondaryEffect = player.playSpace.allSlots[pos].PlaceCard(instance)
		if effects !=null:
			player.playSpace.sideEffectHandler.queu_secondaryEffect(effects)
		return true
class Card_Selected :
	extends Player_State
	var valid_slot : CardSlot
	func _init(p : Player,v_slot : CardSlot ) -> void:
		super(p)
		valid_slot=v_slot
	func process_event(event : InputEvent)->Player_State:
		if event.is_action_pressed("Left mouse Clic") :
			if move_card_from_clic(event) : player.turnSuccessFull.emit()
		if event.is_action_pressed("Right mous Clic") :
			if rotate_card_from_clic(event ) :player.turnSuccessFull.emit()
		return null
	func move_card_from_clic(event : InputEvent)->bool :
		var newPos=player.verrify_Clic_position(event)
		if newPos ==Vector2i(-1,-1) :return false
		if newPos.distance_to(valid_slot.coords)!=1:return false 
		if player.playSpace.allSlots[newPos].haveCarte :
			if sign(player.playSpace.allSlots[newPos].carteData.owner)==sign(player.player_Id) :
				return false
			if sign(player.playSpace.allSlots[newPos].combat_score)!=sign(player.player_Id):
				return false
			player.playSpace.allSlots[newPos].KillCard()
		
		var cardrendered = valid_slot.GiveMovedCard()
		var effects:SecondaryEffect = player.playSpace.allSlots[newPos].ReceiveMovedCard(cardrendered)
		if effects !=null:
			player.playSpace.sideEffectHandler.queu_secondaryEffect(effects)
		return true
	func rotate_card_from_clic(event : InputEvent)->bool :
		var newPos=player.verrify_Clic_position(event)
		if newPos ==Vector2i(-1,-1) :return false
		if newPos.distance_to(valid_slot.coords)!=1:return false
		var newDir : Vector2i = newPos-valid_slot.coords
		if newDir==valid_slot.carteData.direction *-1: return false
		var rotatFunc : Callable = func(x : Carte) : x.direction= newDir
		var effects:SecondaryEffect = valid_slot.RotateCard(rotatFunc)
		if effects !=null:
			player.playSpace.sideEffectHandler.queu_secondaryEffect(effects)
		return true
#endregion
