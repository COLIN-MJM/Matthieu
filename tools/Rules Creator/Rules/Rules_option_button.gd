@tool
class_name Rule_Option_Button
extends OptionButton
@export var textual:RichTextLabel
@export var argument_list:VBoxContainer
@export var folded:FoldableContainer
@export var plus_button:Button

var argument_scene:PackedScene=preload("uid://b3pkf0krao1j7")
var rule_scene:PackedScene=preload("uid://c1toly1av552t")

var argument_array :Array
var statics_arguments : Array
func _ready() -> void:
	if item_count>0 : return
	for filter in (FilterBank.statics.filter(func(x):return!FilterBank.utility_statics.has(x) )):
		add_item(filter)
		add_separator()
	_on_item_selected(0)


func _on_item_selected(index: int) -> void:
	statics_arguments =FilterBank.statics_arguments_dic[get_item_text(index)]
	textual.text=statics_arguments[1]
	folded.title=get_item_text(index)
	
	plus_button.disabled=true
	argument_array.clear()
	for i in argument_list.get_children():
		i.free()
	if statics_arguments[0]==-1:
		plus_button.disabled=false
	else :
		for i in range(2,statics_arguments.size()) :
			if statics_arguments[i]==&"filter":
				var newNode := rule_scene.instantiate() as Rule_scene
				argument_array.append(newNode)
				argument_list.add_child(newNode)
			else:
				var newNode = argument_scene.instantiate() as Argument_scene
				argument_array.append(newNode)
				argument_list.add_child(newNode)
				newNode.indicativ_text.text=statics_arguments[i]

func _on_plus_button_pressed()->void:
	if statics_arguments[2]==&"filter" :
		var newNode := rule_scene.instantiate() as Rule_scene
		argument_array.append(newNode)
		argument_list.add_child(newNode)
