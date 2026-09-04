class_name  CardSlot
extends Sprite3D

var haveCard : bool = false
var cardData : Card 
var coords: Vector2i
var total_pixelsize
var screen_coords : screen_coordinate =screen_coordinate.new()
var combat_score : int
@export var test : ColorRect
@export var test2 : ColorRect
func done() -> void:
	var cam :Camera3D = get_viewport().get_camera_3d()
	screen_coords.lower_point=cam.unproject_position(global_transform.origin)
	screen_coords.upper_point=cam.unproject_position(global_transform.origin+Vector3(total_pixelsize.x,total_pixelsize.y,0))
	test.set_position(screen_coords.lower_point)
	test2.set_position(screen_coords.upper_point)


class screen_coordinate :
	func is_within(input:Vector2)->bool:
		var b : bool =input.x>=lower_point.x and input.x<=upper_point.x and input.y<=lower_point.y and input.y>=upper_point.y
		#print("====","\n","lower bound : ",lower_point,"\n","upper bound : ",upper_point,"\n","event : ",input,"\n",b,"\n","====")
		return b
	var lower_point :Vector2
	var upper_point:Vector2
