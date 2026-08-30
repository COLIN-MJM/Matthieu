@tool
class_name Rule_scene
extends FoldableContainer

var originalMaxsize= self.custom_maximum_size
var originalMinsize= self.custom_minimum_size
@export var button : Rule_Option_Button

var arguments :Array :
	get : return button.argument_array
var filter_name :
	get : return button.filter_name
func _on_folding_changed(is_foldede: bool) -> void:
	if is_foldede:
		custom_maximum_size.y=50
		custom_minimum_size.y=0
	else :
		custom_maximum_size=originalMaxsize
		custom_minimum_size=originalMinsize
