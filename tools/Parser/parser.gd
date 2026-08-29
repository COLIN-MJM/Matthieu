#@tool
class_name Parser
#extends EditorScript
extends Object

static var map : Dictionary[StringName,filter_struct]
static var non_finite_while_limits = 25

static var fBank : FilterBank = FilterBank.new()

#alors plusieur point sur le formatage :
## ouais c'est des string et pas de des enum donc douleur
## "sequence_end"  est à chaque fin de truc , on perd pas de perf et plus simple à codé , mais faut formaté correctement quoi
## les valeurs sont inversé  : filter_dist.bind(Vector,int) => "filter_dist",int,Vector,"sequence_end" me demande pas Pk j'en ais pas la moindre idée
const inputs : Array = [
	&"filtre_dist",
		1,
		Vector2i(7,2),
	&"sequence_end",
	&"op_or",
		&"array_block",
		&"filtre_relative_pos",
			Vector2i.UP,
			Vector2i.RIGHT,
			Vector2i(7,2),
		&"sequence_end",
		&"filtre_relative_pos",
			Vector2i.LEFT,
			Vector2i.RIGHT,
			Vector2i(7,2),
		&"sequence_end",
		&"filtre_relative_pos",
			Vector2i.RIGHT,
			Vector2i.RIGHT,
			Vector2i(7,2),
		&"sequence_end",
	&"sequence_end"]

func _run() -> void:
	Parse(inputs)

static func Parse(inputsToInterpret:Array) -> Callable:
	non_finite_while_limits = inputsToInterpret.size()
	for i in fBank.statics:
		if i  == &"sequence_end" or i  ==&"array_block" : continue
		map.get_or_add(i,filter_struct.new(fBank,null,i))
	var result = interpreter(inputsToInterpret)
	map.clear()
	return result

static func interpreter(inputsToInterpret:Array)->Callable:
	var final_callable : Callable = FilterBank.evaluator.evaluate
	var call_array : Array[Callable]=[]
	var current_block : filter_struct =null
	var i :int = 0
	while i <=inputsToInterpret.size()-1:
		print("big I is ",i)
		if current_block !=null :
			var x: bind_return= bind_to_callable(inputsToInterpret, current_block,i,0)
			call_array.append(x.callable)
			current_block = null
			i=x.next_i
			i+=1
			continue
		if fBank.statics.has(inputsToInterpret[i]) :
			if inputsToInterpret[i] =="sequence_end" or inputsToInterpret[i] =="array_block":
				print("sequence_end or array_block  encounter,skipping iteration")
				i+=1
				continue
			current_block=map[inputsToInterpret[i]]
			print("current block is ",current_block.methode as String," and should be ",inputsToInterpret[i])
			i+=1
			continue
	print("\n","---AND THE FINAL RESULT IS ---","\n")
	for c in call_array :
		var o = c.get_bound_arguments()
		print(o)
		for p in o :
			if p is Callable :
				print(p.get_bound_arguments())
	final_callable=final_callable.bind(call_array,FilterBank.get_test_array())
	var test : Array
	var result : Array=final_callable.call()
	for y in result:
		test.append(y.name)	
	print(test)
	return final_callable
	
static func bind_to_callable(inputsToInterpret:Array, x:filter_struct, i:int, iter : int)->bind_return:
	print(x.callable.get_method())
	var returned: Callable=x.callable
	var y:int =i
	var next_i :int
	var array:Array=[]
	var in_array_block:bool = false
	print("i is : ",i," and thus is : ",inputsToInterpret[i])
	for panic in range(inputsToInterpret.size()):
		var item = inputsToInterpret[y]
		if item is StringName and fBank.statics.has(item) :
			if item==&"sequence_end" :break
			if item==&"array_block" :
				print("entred array_outpout mode for current block")
				in_array_block=true
				y+=1
				next_i=y
				continue
			var result = bind_to_callable(inputsToInterpret, map[item],y+1,iter+1)
			y=result.next_i
			item=result.callable
		assert(y-i<non_finite_while_limits,"sequence_end not encountered , inputsToInterpret may be badly formated")
		print("recursive iter : ",iter," while iter : ",y-i)
		print("next item is ",inputsToInterpret[y+1])
		
		if in_array_block:
			print("appended ", item)
			array.append(item)
		else:
			print("binded ", item)
			returned=returned.bind(item)
		y+=1
		next_i=y
	print("succeful bind")
	if in_array_block :
		print("binded array ", array)
		returned=returned.bind(array)
	return bind_return.new(returned,next_i)


class bind_return :
	var callable : Callable
	var next_i:int
	func _init(c:Callable,ni:int) -> void:
		callable=c
		next_i=ni
