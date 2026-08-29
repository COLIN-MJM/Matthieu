class_name PlaySpace
extends Node2D
@export var dimensions : Vector2i
@export var slotSize : Vector2i

@export var player_manager : Player_Manager
@export_custom(PROPERTY_HINT_RANGE,"0,4,1") var nbr_of_player : int
var board : Node2D
var TlMidBr : PackedVector2Array
@onready var carteSlot : PackedScene =$".".get_meta("CarteSlot")

var scaler : Vector2 
var _midpoint : Vector2

var sideEffectHandler : SideEffectHandler = SideEffectHandler.new(self)

var allSlots :Dictionary[Vector2i,CardSlot]

func _ready() -> void:
	scaler= Vector2(slotSize)/100
	createGrid()
	player_manager.createplayer_sceneS(nbr_of_player)

func createGrid()->void:
	board=Node2D.new()
	add_child(board)
	
	for y in dimensions.y :
		for x in dimensions.x :
			var instance : CardSlot = carteSlot.instantiate()
			instance.position = board.position + Vector2(slotSize.x * x,slotSize.y * y )
			instance.coords = Vector2i(x,y)
			allSlots[Vector2i(x,y)] = instance
			instance.poly.scale = scaler
			board.add_child(instance)
	get_window().size_changed.connect(centerPlayspace)
	_midpoint = Vector2(dimensions.x*slotSize.x,dimensions.y*slotSize.y)/2
	centerPlayspace()
	
func centerPlayspace()->void :
	var center :Vector2 = get_window().size/2
	board.position = center - _midpoint
	TlMidBr=PackedVector2Array([center - _midpoint, center, center + _midpoint])

func Resolve_AttacksAndDefend()->void :
	var slotWithCard = allSlots.values().filter(
		func(x : CardSlot): return x.haveCarte)
	for slot : CardSlot in slotWithCard :
		var tryPos : Vector2i =slot.coords+slot.carteData.direction
		if tryPos.x <dimensions.x and tryPos.x >0 and tryPos.y <dimensions.y and tryPos.y >0  :
			allSlots[tryPos].combat_score+=slot.carteData.strenght
		
	
func Resolve_Passive()->void :
	var filtered =allSlots.keys().filter(
		func(x:Vector2i) :
			return (allSlots[x].haveCarte and allSlots[x].carteData.ActivationType== GlobalCardEnum.ActivationTypes.Passive)
	)
	
	for y in filtered :
		sideEffectHandler.queu_secondaryEffect(allSlots[y].ActivateCard())
	sideEffectHandler.ResolveSecondaryEffects()

func debugCreateCard(at :Vector2i =Vector2i(0,0))->void :
	var ressource : PackedScene = preload("res://CarteInstance.tscn")
	var instance : CarteRenderer =ressource.instantiate()
	instance.CardEffect.direction=Vector2i.RIGHT
	allSlots[at].AssignCard(instance)
	
