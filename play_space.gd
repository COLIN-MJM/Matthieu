class_name PlaySpace
extends Node2D
@export var dimensions : Vector2i
@export var slotSize : Vector2i

@onready var carteSlot : PackedScene =$".".get_meta("CarteSlot")
@onready var player_scene : PackedScene =$".".get_meta("PlayerScene")

var sideEffectHandler : SideEffectHandler = SideEffectHandler.new(self)

var allSlots :Dictionary[Vector2i,CardSlot]

func _ready() -> void:
	createGrid()
	createplayer_scene()



func createplayer_scene()->void:
	var player : Player = player_scene.instantiate()
	player.playSpace= self
	add_child(player)


func createGrid()->void:
	for y in dimensions.y :
		for x in dimensions.x :
			var instance : CardSlot = carteSlot.instantiate()
			instance.position =position+ Vector2(slotSize.x *x,slotSize.y * y )
			instance.coords=Vector2i(x,y)
			allSlots[Vector2i(x,y)]= instance
			add_child(instance)

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
	
