class_name Argument_scene
extends HBoxContainer

@export var indicativ_text: RichTextLabel
@export var line_edit:LineEdit

var argument



func _on_line_edit_text_submitted(new_text: String) -> void:
	argument=str_to_var(new_text)
