@tool
class_name Rules_Formater
extends EditorScript

signal format_complete(Array)

const inputs : Array = [ 
	&"filtre_dist",
		&"self_position",
		1,
	&"op_or",
		&"filtre_relative_pos",
			&"self_position",
			Vector2i.UP,
		&"filtre_relative_pos",
			&"self_position",
			Vector2i.LEFT,
		&"filtre_relative_pos",
			&"self_position",
			Vector2i.RIGHT,
]


func _run() -> void:
	print(Receive_Unformated(inputs))


static func Receive_Unformated(input_array:Array)->Array :
	var result : Array=[]
	var curr_bloc:Array=[]
	var i :int = 0
	while i <=inputs.size()-1:
		if (input_array[i] is not StringName or !FilterBank.statics.has(input_array[i] as StringName)) or (input_array[i] is StringName and FilterBank.self_blocs.has(input_array[i] as StringName)) :
			curr_bloc.append(input_array[i])
		else :
			if !curr_bloc.is_empty() : 
				curr_bloc.reverse()
				curr_bloc.append(&"sequence_end")
			curr_bloc.append(input_array[i])
			if FilterBank.array_block_needed.has(input_array[i]) :
				curr_bloc.append(&"array_block")
			result.append_array(curr_bloc)
			curr_bloc.clear()
		i+=1
	result.append(&"sequence_end")
	result.append(&"sequence_end")
	return result
