class_name Carte_12
extends Carte
func _init() -> void:
	ActivationType= GlobalCardEnum.ActivationTypes.OnMove

var dimension : Vector2i =Vector2i(-1,-1)
var playspace : PlaySpace
var mooveDir : Vector2i
func Activate()->SecondaryEffect:
	var targets : Array[Vector2i]
	if dimension == Vector2i(-1,-1) :
		playspace = carteRenderer.get_node("/root/Node2D")
		dimension=playspace.dimensions
	mooveDir = position-oldPosition
	var number : int = floor(((dimension - position) *mooveDir).length())
	for i in range(number-1) :
		targets.append(position+ mooveDir +(mooveDir*i ))
	targets.reverse()
	var effects :SecondaryEffect = SecondaryEffect.new(targets,afterEffect)
	return effects

func AfterEffect(entrance:Carte)->void:
	if !playspace.allSlots[entrance.position+mooveDir].haveCarte :
		var  x = playspace.allSlots[entrance.position].GiveMovedCard()
		var effects =playspace.allSlots[entrance.position+mooveDir].ReceiveMovedCard(x)
		if effects !=null:
			playspace.sideEffectHandler.queu_secondaryEffect(effects)
	
