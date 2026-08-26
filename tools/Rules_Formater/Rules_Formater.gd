@tool
class_name Rules_Formater
extends EditorScript

signal format_complete(Array)

const inputs : Array = [ 
	FilterBank.statics.filtre_dist,
		Vector2i(7,2),
		1,
	FilterBank.statics.sequence_end,
	FilterBank.statics.orer,
		FilterBank.statics.array_block,
		FilterBank.statics.filtre_relative_pos,
			Vector2i(7,2),
			Vector2i.UP,
		FilterBank.statics.sequence_end,
		FilterBank.statics.filtre_relative_pos,
			Vector2i(7,2),
			Vector2i.LEFT,
		FilterBank.statics.sequence_end,
		FilterBank.statics.filtre_relative_pos,
			Vector2i(7,2),
			Vector2i.RIGHT,
		FilterBank.statics.sequence_end,
	FilterBank.statics.sequence_end]


func _run() -> void:
	print(inputs)
	print(Receive_Unformated(inputs))


static func Receive_Unformated(input_array:Array)->Array :
	var result : Array=[]
	var curr_bloc:Array=[]
	var i :int = 0
	while i <=inputs.size()-1:
		if input_array[i] is FilterBank.statics :
			curr_bloc.append(enum_to_string(input_array[i]))
		else :
			curr_bloc
		i+=1
		result.append_array(curr_bloc)
		curr_bloc.clear()
	return result

static func enum_to_string(x:FilterBank.statics)->String :
	return FilterBank.statics.find_key(x)
