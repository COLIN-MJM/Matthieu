class_name bite
extends Control

@export var oi:Array[Callable]
var array : Array[cart]
var pos : Vector2i = Vector2i(7,2)
var ow : bool = true
var rotr : int =1




func filtre_dist(i:cart,who:Vector2i,dist:int)->bool :
	return i.pos.distance_squared_to(who)<=dist
func filtre_direction(i :cart,dir:int)->bool : 
	return i.rotation==dir

func filtre_relative_pos(i:cart,who:Vector2i,dir:Vector2i)->bool:
	return Vector2(i.pos-who).normalized()==Vector2(dir)

func orer(i: cart,possible :Array)->bool:
	for callable in possible :
		if callable.call(i) : return true
	return false
func _ready()->void :

	array =[cart.new(Vector2i(7,1),true,1,"1"),cart.new(Vector2i(6,1),false,1,"2"),cart.new(Vector2i(8,2),true,2,"3")]
	Rotate(1,evaluator.evaluate([
			filtre_dist.bind(pos,1),
			orer.bind([
				filtre_relative_pos.bind(pos,Vector2i.UP),
				filtre_relative_pos.bind(pos,Vector2i.LEFT),
				filtre_relative_pos.bind(pos,Vector2i.RIGHT)])],
		array))

func Rotate(angle : int,targets : Array[cart])->SecondaryEffect :
	for c in targets :
		c.rotation+=angle
		return c.When(GlobalCardEnum.ActivationTypes.OnRotate)
	return null


class cart :
	var name : StringName
	var pos : Vector2i
	var owner : bool
	var rotation : int
	
	func _init(vec : Vector2i, b : bool ,rot : int, s : StringName) -> void:
		name=s
		pos=vec
		owner=b
		rotation=rot
	func When(source : GlobalCardEnum.ActivationTypes)->SecondaryEffect:
		if false : return
		return null
class evaluator :
	static func evaluate(filter:Array[Callable],i:Array[Variant])-> Array[Variant] :
		for f in filter :
			i=i.filter(f)
		return i
