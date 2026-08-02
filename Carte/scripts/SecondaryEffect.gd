
class_name SecondaryEffect
extends Resource

var targetsCoords :Array[Vector2i]
var effectToDo:Callable

func _init(targetCoords:Array[Vector2i],callable:Callable) -> void:
	targetsCoords=targetCoords
	effectToDo=callable
