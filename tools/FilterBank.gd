@tool
class_name FilterBank
extends EditorScript

const statics : Array[StringName]= ["filtre_dist", "filtre_direction", "filtre_relative_pos", "filtre_team", "op_not", "op_nand", "op_xor", "op_or", "sequence_end", "array_block"]
const array_block_needed : Array[StringName]= ["op_nand", "op_xor", "op_or"]

static func get_test_array()->Array[Card]:
	var test : Array
	var toreturn : Array[Card] = [Card.new("1",Vector2i(7,1),Vector2i.RIGHT,true),Card.new("2",Vector2i(6,1),Vector2i.RIGHT,false),Card.new("3",Vector2i(8,2),Vector2i.DOWN,true)]
	for y in toreturn:
		test.append(y.name)
	print(test)
	return toreturn

## Vérifie que la distance de la carte étudiée i vis-à vis de la position "who" est plus petite ou égale à "dist"
static func filtre_dist(i:Card, who:Vector2i, dist:int)->bool :
	return i.pos.distance_squared_to(who)<=dist
	
## Vérifie que la direction de la carte étudiée i est égale à "dir"
static func filtre_direction(i:Card, dir:Vector2i)->bool : 
	return i.rotation==dir

## Vérifie que la position de la carte étudiée i est n'importe où sur la direction "dir" de la carte en position "who"
static func filtre_relative_pos(i:Card, whoPos:Vector2i, whoDir:Vector2i, relativeDir:Vector2i)->bool:
	var comparedDir : Vector2 = Vector2(whoDir)
	var angle : float = Vector2.UP.angle_to(relativeDir)
	comparedDir = comparedDir.rotated(angle)
	return Vector2i(Vector2(i.position-whoPos).normalized())==Vector2i(comparedDir)

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

class Rules:
	var Action : Callable

class evaluator :
	static func evaluate(filter:Array[Callable],i:Array[Variant])-> Array[Variant] :
		for f in filter :
			i=i.filter(f)
		print(i)
		return i
