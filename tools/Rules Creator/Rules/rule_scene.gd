class_name Rule_scene
extends FoldableContainer

var originalMaxsize= self.custom_maximum_size
var originalMinsize= self.custom_minimum_size
func _on_folding_changed(is_foldede: bool) -> void:
	if is_foldede:
		custom_maximum_size.y=50
		custom_minimum_size.y=0
	else :
		custom_maximum_size=originalMaxsize
		custom_minimum_size=originalMinsize
