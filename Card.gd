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

var whenToActivate : Array[GlobalCardEnum.ActivationTypes]
var alreadyActivatedThisTurn : bool = false

func _ready() -> void:
	#_init("MyCard", Vector2i(7, 2), Vector2i.UP, true)
	whenToActivate.append(GlobalCardEnum.ActivationTypes.OnPlacement)
	When(GlobalCardEnum.ActivationTypes.OnMove)
	When(GlobalCardEnum.ActivationTypes.OnPlacement)

func _init(s : StringName, pos : Vector2i, rot : Vector2i, ow : bool) -> void:
	name=s
	position=pos
	rotation=rot
	owner=ow
	
func When(source : GlobalCardEnum.ActivationTypes)->SecondaryEffect:
	if (source == null || alreadyActivatedThisTurn) : return null
	for con in whenToActivate:
		if (con == source) : 
			print("Corresponding condition! Let's Continue!")
			return Activate()
	print("Nope...")
	return null

func Activate()->SecondaryEffect:
	alreadyActivatedThisTurn = true
	rule.Reparse(rule.allFilters)
	var concernedCards : Array = rule.callableFilters.call()
	print(concernedCards)
	return null
	
