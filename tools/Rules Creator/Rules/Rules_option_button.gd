@tool
class_name Rule_Option_Button
extends OptionButton
@export var textual:RichTextLabel
@export var argument_list:VBoxContainer

func _ready() -> void:
	for filter in (FilterBank.statics.filter(func(x):return!FilterBank.utility_statics.has(x) )):
		add_item(filter)
		add_separator()
	_on_item_selected(0)


func _on_item_selected(index: int) -> void:
	textual.text=FilterBank.statics_arguments_dic[get_item_text(index)][1]
	pass
