class_name CarteRenderer
extends Node2D

var CardEffect:Carte 
@export var arrow :Node2D

func _process(_delta: float) -> void :
	var dirToRot : float
	match CardEffect.direction :
		Vector2i.UP :
			dirToRot=0
		Vector2i.RIGHT:
			dirToRot=90
		Vector2i.DOWN:
			dirToRot=180
		Vector2i.LEFT:
			dirToRot=270
	arrow.global_rotation_degrees=dirToRot
