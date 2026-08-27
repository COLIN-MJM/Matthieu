@tool
class_name ActionsBank
extends EditorScript

static func Rotate(targets:Array[Card], angle:float)->SecondaryEffect:
	for c in targets :
		c.rotation=Vector2(c.rotation).rotated(angle)
		return c.When(GlobalCardEnum.ActivationTypes.OnRotate)
	return null
