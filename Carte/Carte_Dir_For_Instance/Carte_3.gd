class_name Carte_3
extends Carte
func _ready() -> void:
	ActivationType= GlobalCardEnum.ActivationTypes.OnPlacement


func Activate()->SecondaryEffect:
	var targets : Array[Vector2i]
	targets.append(position+Vector2i.UP)
	targets.append(position+Vector2i.RIGHT)
	targets.append(position+Vector2i.DOWN)
	targets.append(position+Vector2i.LEFT)
	
	var effects :SecondaryEffect = SecondaryEffect.new(targets,afterEffect)
	return effects

func AfterEffect(entrance:Carte):
	entrance.direction= entrance.direction*-1
	pass
