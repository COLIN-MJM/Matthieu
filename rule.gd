class_name Rule
extends Resource

var bindedCard : Card

@export var rule_name : StringName
@export var whenToActivate : Array[GlobalCardEnum.ActivationTypes]

@export_custom(PROPERTY_HINT_NONE, "", PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_READ_ONLY) 
var rawFilters : Array
@export var rawAction : ActionsBank.ActionWord 

var updatedFilters : Array
@export_custom(PROPERTY_HINT_NONE, "", PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_READ_ONLY) 
var updatedAction : StringName

var callableFilters : Callable
var callableActions : Callable

func _init(wta:Array[GlobalCardEnum.ActivationTypes] = [GlobalCardEnum.ActivationTypes.Null], filters:Array = [&"sequence_end"], action:ActionsBank.ActionWord = ActionsBank.ActionWord.Null) -> void:
	whenToActivate = wta
	rawFilters = filters
	rawAction = action

func CreateActionCallable(Ab:ActionsBank)->void:
	callableActions=Callable.create(Ab,updatedAction)

func Reparse(f:Array,c :Array[Card]) -> void:
	callableFilters = Parser.Parse(f,c)
