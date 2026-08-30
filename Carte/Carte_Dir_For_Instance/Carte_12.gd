class_name Carte_12
extends Carte
func _init() -> void:
	super()
	ActivationType= GlobalCardEnum.ActivationTypes.OnMove

var dimension : Vector2i =Vector2i(-1,-1)
var playspace : PlaySpace
var mooveDir : Vector2i
func Activate()->SecondaryEffect:
	var targets : Array[Vector2i]
	if dimension == Vector2i(-1,-1) :
		playspace = cardRenderer.get_node("/root/Node2D")
		dimension=playspace.dimensions - Vector2i(1,1)
	mooveDir = position-oldPosition
	var number : int
	match mooveDir :
		Vector2i.UP:
			number=position.y
		Vector2i.LEFT :
			number=position.x
		Vector2i.RIGHT :
			number = dimension.x-position.x
		Vector2i.DOWN :
			number = dimension.y-position.y
	for i in range(number - 1) :
		targets.append(position+mooveDir +(mooveDir*i ))
	targets.reverse()
	var effects :SecondaryEffect = SecondaryEffect.new(targets,afterEffect)
	return effects

func AfterEffect(entrance:Carte)->void:
	if !playspace.allSlots[entrance.position+mooveDir].haveCarte :
		var  x = playspace.allSlots[entrance.position].GiveMovedCard()
		var effects =playspace.allSlots[entrance.position+mooveDir].ReceiveMovedCard(x)
		if effects !=null:
			playspace.sideEffectHandler.queu_secondaryEffect(effects)
	
