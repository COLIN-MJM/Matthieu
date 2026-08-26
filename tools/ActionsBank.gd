@tool
class_name ActionsBank
extends EditorScript

static func Rotate(targets:Array[Card], angle:int)->SecondaryEffect:
	for c in targets :
		c.rotation += angle
		return c.When(GlobalCardEnum.ActivationTypes.OnRotate)
	return null
