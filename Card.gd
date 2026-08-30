class_name Card
extends Object

var name : StringName
var position : Vector2i
var rotation : Vector2i
var owner : bool 

var rule : Rule

var parameters : Dictionary[StringName, int] = { 
	&"Zoc":1,
	&"CombatValue":1
	}

var alreadyActivatedThisTurn : bool = false

func _ready() -> void:
	#_init("MyCard", Vector2i(7, 2), Vector2i.UP, true)
	rule.whenToActivate.append(GlobalCardEnum.ActivationTypes.OnPlacement)
	When(GlobalCardEnum.ActivationTypes.OnMove)
	When(GlobalCardEnum.ActivationTypes.OnPlacement)

func _init(s : StringName, pos : Vector2i, rot : Vector2i, ow : bool) -> void:
	name=s
	position=pos
	rotation=rot
	owner=ow
	
func When(source : GlobalCardEnum.ActivationTypes)->SecondaryEffect:
	if (source == null || alreadyActivatedThisTurn) : return null
	if rule.whenToActivate.has(source) : 
		print("Corresponding condition! Let's Continue!")
		return Activate()
	print("Nope...")
	return null

func Activate()->SecondaryEffect:
	alreadyActivatedThisTurn = true
	rule.updatedFilters = UpdateFilters(rule.rawFilters)
	rule.Reparse(rule.updatedFilters)
	var concernedCards : Array = rule.callableFilters.call()
	print(concernedCards)
	return null

func UpdateFilters(filters:Array)->Array:
	var tempFilters : Array = filters
	var i : int = tempFilters.size() - 1
	while i >= 0:
		tempFilters[i] = UpdateBloc(tempFilters[i])
		i = i - 1
	return tempFilters

func UpdateBloc(bloc:Variant)->Variant:
	if !FilterBank.self_blocs.has(bloc) : return bloc
	match bloc :
		&"self_position": return position
		&"self_rotation": return rotation
		&"self_owner": return owner
		_: return bloc
