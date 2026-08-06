class_name Carte_3
extends Carte
func _init() -> void:
	ActivationType= GlobalCardEnum.ActivationTypes.OnPlacement

var playspace : PlaySpace
func Activate()->SecondaryEffect:
	if playspace == null :
		playspace = carteRenderer.get_node("/root/Node2D")
	var targets : Array[Vector2i]
	targets.append(position+Vector2i.UP)
	targets.append(position+Vector2i.RIGHT)
	targets.append(position+Vector2i.DOWN)
	targets.append(position+Vector2i.LEFT)
	
	targets=targets.filter(
		func(o : Vector2i) :return !(o.x >playspace.dimensions.x or o.x <0 or o.y >playspace.dimensions.y or o.y <0))
	
	var effects :SecondaryEffect = SecondaryEffect.new(targets,afterEffect)
	return effects

func AfterEffect(entrance:Carte)->void:
	var rotationFunc = func(x:Carte) :x.direction= x.direction *-1
	playspace.allSlots[entrance.position].RotateCard(rotationFunc)
