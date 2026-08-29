class_name Rule
extends Node

var bindedCard : Card
var allFilters : Array
var actions : Array

var callableFilters : Callable
var callableActions : Callable

func _ready() -> void:
	Reparse(allFilters)

func Reparse(f:Array) -> void:
	callableFilters = Parser.Parse(f)
