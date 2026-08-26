class_name filter_struct
extends Resource
var callable : Callable
var FilterBanke : FilterBank
@export var methode : String :
	get : return methode
	set(value) :
		if callable !=null:
			callable=Callable.create(FilterBanke,value)
		methode=value 
@export var finite : int = -1
func _init(b:FilterBank,du:filter_struct=null,s : StringName="" ):
	FilterBanke=b
	if du != null:
		callable=du.callable
		finite=du.finite
		methode=du.methode
		return
	if s !="":
		methode=s
