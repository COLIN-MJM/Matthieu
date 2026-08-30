class_name CardRenderer
extends Node2D

@export var arrow : Node2D
@export var spriteMain : Sprite2D
@export var playerColor : Polygon2D
@export var teamColor : Polygon2D

@export var CardEffect:Card :
	get :
		return CardEffect
	set (value):
		spriteMain.texture=value.sprite
		value.cardRenderer = self
		if value.c_owner : 
			teamColor.color = Color.BLACK
			playerColor.color=Color.RED
		else : 
			teamColor.color = Color.WHITE
			playerColor.color=Color.RED
		CardEffect=value

func process_card_rotate() -> void :
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
