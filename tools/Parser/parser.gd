@tool
class_name Parser
extends EditorScript

enum statics{filtre_dist,filtre_direction,filtre_relative_pos,orer,filter_owner,sequence_end}

@export var map : Dictionary[StringName,filter_struct]
const non_finite_while_limits = 25
const inputs : Array = ["filtre_dist",Vector2i(7,2),1,"sequence_end","orer","filtre_relative_pos",Vector2i(7,2),Vector2i.UP,"sequence_end","filtre_relative_pos",Vector2i(7,2),Vector2i.LEFT,"sequence_end","filtre_relative_pos",Vector2i(7,2),Vector2i.RIGHT,"sequence_end","sequence_end"]

var b : bite
func _run() -> void:
	b=bite.new()
	for i in statics.keys():
		if i  == "sequence_end": continue
		map.get_or_add(i,filter_struct.new(b,null,i))
	interpreter()
	
func interpreter():
	var final_callable : Callable = bite.evaluator.evaluate
	var call_array : Array[Callable]=[]
	var current_block : filter_struct =null
	var i :int = 0
	while i <=inputs.size()-1:
		print("big I is ",i)
		if current_block !=null :
			var x: bind_return= test_bind_to_callable(current_block,i,0)
			call_array.append(x.callable)
			current_block = null
			i=x.next_i
			i+=1
			continue
			
		if statics.has(inputs[i]) :
			if inputs[i] =="sequence_end":
				print("sequence_end encounter ,skipping iteration")
				i+=1
				continue
			current_block=filter_struct.new(b,map[inputs[i]])
			print("current block is ",current_block.methode as String," and should be ",inputs[i])
			i+=1
			continue
	print("\n","---AND THE FINAL RESULT IS ---","\n")
	for c in call_array :
		var o = c.get_bound_arguments()
		print(o)
		for p in o :
			if p is Callable :
				print(p.get_bound_arguments())
	final_callable=final_callable.bind(call_array,bite.get_test_array())
	var test : Array
	var result : Array=final_callable.call()
	for y in result:
		test.append(y.name)	
	print(test)
func test_bind_to_callable(x:filter_struct,i:int,iter : int)->bind_return:
	
	var returned: Callable=x.callable
	var y:int =i
	var next_i :int
	print("i is : ",i," and thus is : ",inputs[i])
	while true :
		var item = inputs[y]
		if statics.has(item)  and statics[item]==statics.sequence_end :break
		print("recursive iter : ",iter," while iter : ",y-i)
		assert(y-i<non_finite_while_limits,"sequence_end not encountered , inputs may be badly formated")
		print("next item is ",inputs[y+1])
		if statics.has(item)  :
			var result = test_bind_to_callable(map[item],y+1,iter+1)
			y=result.next_i
			item=result.callable
		print("binded ", item)
		returned=returned.bind(item)
		y+=1
		next_i=y
		
	print("succeful bind")
	return bind_return.new(returned,next_i)

func bind_to_callable(x:filter_struct,i:int)->bind_return:
	
	var returned: Callable
	if x.finite !=-1:
		for y in range(i+1,x.finite) :
			var item = inputs[y]
			if item is statics and item != statics.sequence_end :
				item = bind_to_callable(map[item],i)
				y+=item.next_i
				item=item.callable
			returned=x.callable.bind(item)
			
	else :
		var y:int =i
		while true :
			y+=1
			
			if y-i>non_finite_while_limits : push_error("sequence_end not encountered , inputs may be badly formated")
			if  inputs[y] is statics and inputs[y]==statics.sequence_end :break
			var item = inputs[y]
			if item is statics :
				item = bind_to_callable(map[item],i)
				y+=item.next_i
				item=item.callable
			returned=x.callable.bind(item)
			
	return bind_return.new(returned,0)

class bind_return :
	var callable : Callable
	var next_i:int
	func _init(c:Callable,ni:int) -> void:
		callable=c
		next_i=ni
