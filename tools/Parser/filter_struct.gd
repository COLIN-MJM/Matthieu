class_name filter_struct
extends Resource
var callable : Callable
var bitee : bite
@export var methode : String :
	get : return methode
	set(value) :
		if callable !=null:
			callable=Callable.create(bitee,value)
		methode=value 
@export var finite : int = -1
func _init(b:bite,du:filter_struct=null,s : StringName="" ):
	bitee=b
	if du != null:
		callable=du.callable
		finite=du.finite
		methode=du.methode
		return
	if s !="":
		methode=s
