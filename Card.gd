class_name Card
extends Node2D

var c_name : StringName
var c_position : Vector2i
var c_rotation : Vector2i
var c_owner : bool 

var rule : Rule

var parameters : Dictionary[StringName, int] = { 
	&"Zoc":1,
	&"CombatValue":1
	}

var alreadyActivatedThisTurn : bool = false

@onready var cardRenderer: CardRenderer = %CardRenderer


func _ready() -> void:
	c_name = "MyCard"
	c_position = Vector2i(7, 2)
	c_rotation = Vector2i.UP
	c_owner = true
	
	rule = Rule.new(
	[GlobalCardEnum.ActivationTypes.OnPlacement], 
	[&"filtre_dist", 1, &"self_position", &"sequence_end"],
	[&"Rotate"])
	
	When(GlobalCardEnum.ActivationTypes.OnMove)
	When(GlobalCardEnum.ActivationTypes.OnPlacement)

func _init(s : StringName = &"MyCard", pos : Vector2i = Vector2i(-1, -1), rot : Vector2i = Vector2i.UP, ow : bool = true) -> void:
	c_name=s
	c_position=pos
	c_rotation=rot
	c_owner=ow
	
func When(source : GlobalCardEnum.ActivationTypes)->SecondaryEffect:
	if (source == null || alreadyActivatedThisTurn) : return null
	if rule.whenToActivate.has(source) : 
		print("Corresponding condition! Let's Continue!")
		return Activate()
	print("Nope...")
	return null

func Activate()->SecondaryEffect:
	alreadyActivatedThisTurn = true
	rule.updatedFilters = UpdateFilters(rule.rawFilters)
	var cards = FilterBank.get_test_array(self)
	rule.Reparse(rule.updatedFilters,cards)
	var concernedCards : Array = rule.callableFilters.call()
	print(concernedCards)
	return null

func UpdateFilters(filters:Array)->Array:
	var tempFilters : Array = filters
	var i : int = tempFilters.size() - 1
	while i >= 0:
		tempFilters[i] = UpdateBloc(tempFilters[i])
		i = i - 1
	return tempFilters

func UpdateBloc(bloc:Variant)->Variant:
	if bloc is not StringName or !FilterBank.self_blocs.has(bloc) : return bloc
	match bloc :
		&"self_position": return c_position
		&"self_rotation": return c_rotation
		&"self_owner": return c_owner
		_: return bloc
