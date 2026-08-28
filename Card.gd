class_name Card
extends Object

var name : StringName
var position : Vector2i
var rotation : Vector2i
var owner : bool
var Activate :Callable 

var parameters:Dictionary[StringName, int] = { 
	&"Zoc":1,
	&"CombatValue":1
	}



func _init(s : StringName, pos : Vector2i, rot : Vector2i, ow : bool) -> void:
	name=s
	position=pos
	rotation=rot
	owner=ow
	
func When(source : GlobalCardEnum.ActivationTypes)->SecondaryEffect:
	if false : return
	return null
