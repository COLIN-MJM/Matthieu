class_name  CardSlot
extends Sprite3D

var haveCard : bool = false
var cardData : Card 
var coords: Vector2i
var total_pixelsize
var screen_coords : screen_coordinate =screen_coordinate.new()
var combat_score : int

var isBase : int :
	set(value) :
		match value :
			0 :
				#modulate =Color.AZURE
				isBase=value
			1:
				#modulate =Color.AQUAMARINE
				isBase=value
			2:
				#modulate =Color.PALE_VIOLET_RED
				isBase=value
var inT1control:bool= false:
	set(value) :
		match value :
			true :
				var c :=Color.RED
				if modulate == Color.WHITE:	modulate=c
				else :
					c.a=0.5
					modulate =modulate.blend(c)
				inT1control=value
			false	:
				modulate =Color.WHITE
				inT1control=value
var inT2control:bool= false	:
	set(value) :
		match value :
			true :
				var c :=Color.BLUE
				if modulate == Color.WHITE:modulate=c
				else :
					c.a=0.5
					modulate =modulate.blend(c)
				inT2control=value
			false	:
				modulate =Color.WHITE
				inT2control=value
func done() -> void:
	var cam :Camera3D = get_viewport().get_camera_3d()
	screen_coords.lower_point=cam.unproject_position(global_transform.origin)
	screen_coords.upper_point=cam.unproject_position(global_transform.origin+Vector3(total_pixelsize.x,total_pixelsize.y,0))


class screen_coordinate :
	func is_within(input:Vector2)->bool:
		var b : bool =input.x>=lower_point.x and input.x<=upper_point.x and input.y<=lower_point.y and input.y>=upper_point.y
		#print("====","\n","lower bound : ",lower_point,"\n","upper bound : ",upper_point,"\n","event : ",input,"\n",b,"\n","====")
		return b
	var lower_point :Vector2
	var upper_point:Vector2
