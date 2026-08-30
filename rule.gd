class_name Rule
extends Node

var bindedCard : Card

var rawFilters : Array
var rawActions : Array

var updatedFilters : Array
var updatedActions : Array

var callableFilters : Callable
var callableActions : Callable

var whenToActivate : Array[GlobalCardEnum.ActivationTypes]

func _init(wta:Array[GlobalCardEnum.ActivationTypes], filters:Array, actions:Array) -> void:
	whenToActivate = wta
	rawFilters = filters
	rawActions = actions

func Reparse(f:Array) -> void:
	callableFilters = Parser.Parse(f)
