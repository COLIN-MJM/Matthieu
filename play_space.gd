class_name PlaySpace
extends Node2D
@export var dimensions : Vector2i
@export var slotSize : Vector2i

@export var player_manager : Player_Manager
@export_custom(PROPERTY_HINT_RANGE,"0,4,1") var nbr_of_player : int
var board : Node2D
var TlMidBr : PackedVector2Array
@onready var carteSlot : PackedScene =$".".get_meta("CarteSlot")


var  scaler : Vector2 

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
			instance.position =board.position+ Vector2(slotSize.x *x,slotSize.y * y )
			instance.coords=Vector2i(x,y)
			allSlots[Vector2i(x,y)]= instance
			instance.poly.scale=scaler
			board.add_child(instance)
	get_window().size_changed.connect(centerPlayspace)
	_midpoint=Vector2(dimensions.x*slotSize.x,dimensions.y*slotSize.y)/2
	
	centerPlayspace()
var _midpoint : Vector2
func centerPlayspace()->void :
	var center :Vector2 = get_window().size/2
	board.position=center-_midpoint
	TlMidBr=PackedVector2Array([center-_midpoint,center,center+_midpoint])

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
	
