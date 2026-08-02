extends Carte

func _ready() -> void:
	ActivationType= GlobalCardEnum.ActivationTypes.OnPlacement


func Activate()->SecondaryEffect:
	var targets : Array[Vector2i]=[]
	targets[0]=position+Vector2i.UP
	targets[1]=position+Vector2i.RIGHT
	targets[2]=position+Vector2i.DOWN
	targets[3]=position+Vector2i.LEFT
	
	var effects :SecondaryEffect = SecondaryEffect.new(targets,afterEffect)
	return effects

func AfterEffect(entrance:Carte):
	entrance.direction= entrance.direction*-1
	pass
