class_name  Rules_container
extends ScrollContainer

@export var vertical_Aligner : VBoxContainer

func add_rules(node:Control)->void:
	vertical_Aligner.add_child(node)
