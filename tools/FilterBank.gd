@tool
class_name FilterBank
extends EditorScript

enum statics{filtre_dist, filtre_direction, filtre_relative_pos, filtre_team, op_not, op_nand, op_xor, op_or, filter_owner, sequence_end, array_block}

@export var oi:Array[Callable]
var array : Array[Card]
var pos : Vector2i = Vector2i(7,2)
var ow : bool = true
var rota : int =1

static func get_test_array()->Array[Card]:
	var test : Array
	var toreturn :Array[Card] = [Card.new(Vector2i(7,1),true,1,"1"),Card.new(Vector2i(6,1),false,1,"2"),Card.new(Vector2i(8,2),true,2,"3")]
	for y in toreturn:
		test.append(y.name)
	print(test)
	return toreturn

## Vérifie que la distance de la carte étudiée i vis-à vis de la position "who" est plus petite ou égale à "dist"
static func filtre_dist(i:Card, who:Vector2i, dist:int)->bool :
	return i.pos.distance_squared_to(who)<=dist
	
## Vérifie que la direction de la carte étudiée i est égale à "dir"
static func filtre_direction(i:Card, dir:int)->bool : 
	return i.rotation==dir

## Vérifie que la position de la carte étudiée i est n'importe où sur la direction "dir" de la carte en position "who"
static func filtre_relative_pos(i:Card, whoPos:Vector2i, whoDir:int, relativeDir:int)->bool:
	var possibleDirs : Array[Vector2i] = [Vector2i.UP, Vector2i.RIGHT, Vector2i.DOWN, Vector2i.LEFT]
	var comparedDirIndex : int = (whoDir + relativeDir) % 4 
	return Vector2(i.pos-whoPos).normalized()==Vector2(possibleDirs[comparedDirIndex])

## Vérifie l'équipe de la carte étudiée i par rapport à l'équipe "who". 
## Si "allyOrEnemy" est vrai, on vérifie qu'elles sont dans la même équipe. Sinon, on vérifie qu'elles sont dans des équipes opposées.
static func filtre_team(i:Card, who:bool, allyOrEnemy:bool)->bool:
	return (i.owner == who) == allyOrEnemy
	
## Opérateur inversant la validité du filtre "filter".
static func op_not(i:Card, filter:Callable)->bool:
	return !filter.call(i)

## Opérateur vérifiant qu'au moins un filtre testés dans "possible" est faux.
static func op_nand(i:Card, possible:Array)->bool:
	for callable in possible :
		if !callable.call(i) : return true
	return false

## Opérateur vérifiant qu'un seul des filtres testés dans "possible" est vrai.
static func op_xor(i:Card, possible:Array)->bool:
	var nbOfTrueConditions = 0;
	for callable in possible :
		if callable.call(i) : nbOfTrueConditions += 1
		if nbOfTrueConditions > 1 : return false
	return true

## Opérateur vérifiant qu'au moins un des filtres testés dans "possible" est vrai.
static func op_or(i: Card, possible:Array)->bool:
	for callable in possible :
		if callable.call(i) : return true
	return false
	
	
func _ready()->void :

	array =[Card.new(Vector2i(7,1),true,1,"1"),Card.new(Vector2i(6,1),false,1,"2"),Card.new(Vector2i(8,2),true,2,"3")]
	var active_filters : Callable = evaluator.evaluate.bind(
		[filtre_dist.bind(pos,1),op_or.bind([filtre_relative_pos.bind(pos,Vector2i.UP),filtre_relative_pos.bind(pos,Vector2i.LEFT),filtre_relative_pos.bind(pos,Vector2i.RIGHT)])],array)
	
	Rotate(1,active_filters.call())

static func Rotate(angle : int,targets : Array[Card])->SecondaryEffect :
	for c in targets :
		c.rotation+=angle
		return c.When(GlobalCardEnum.ActivationTypes.OnRotate)
	return null



class Rules:
	var Action : Callable

class Card :
	var name : StringName
	var pos : Vector2i
	var owner : bool
	var rotation : int
	var Activate :Callable 
	func _init(vec : Vector2i, b : bool ,rot : int, s : StringName) -> void:
		name=s
		pos=vec
		owner=b
		rotation=rot
	func When(source : GlobalCardEnum.ActivationTypes)->SecondaryEffect:
		if false : return
		return null
	
	var zoc : PackedByteArray = PackedByteArray([0, 0])

class evaluator :
	static func evaluate(filter:Array[Callable],i:Array[Variant])-> Array[Variant] :
		for f in filter :
			i=i.filter(f)
		print(i)
		return i
