@tool
class_name ActionsBank
extends EditorScript

var playspace

enum ActionWord{
	RotateAll,MoveAll,AttractOrPushAway,RotateTowardsOrAway,BuffAll}
	


#region Actions Fondamentales

static func Rotate(target:Card, angle:float)->SecondaryEffect:
	target.c_rotation = Vector2(target.c_rotation).rotated(angle)
	return target.When(GlobalCardEnum.ActivationTypes.OnRotate)

static func Move(target:Card, dir:Vector2i, nbTiles:int)->SecondaryEffect:
	target.c_position += dir * nbTiles
	return target.When(GlobalCardEnum.ActivationTypes.OnMove)

static func Buff(target:Card, parameter:StringName, addedValue:int)->SecondaryEffect:
	target.parameters[parameter] += addedValue
	return target.When(GlobalCardEnum.ActivationTypes.OnBuff)

#endregion

#region Actions Multi-Cibles

static func RotateAll(targets:Array[Card], angle:float)->SecondaryEffect:
	for c in targets :
		return Rotate(c, angle)
	return null
	
static func MoveAll(targets:Array[Card], dir:Vector2i, nbTiles:int)->SecondaryEffect:
	for c in targets :
		return Move(c, dir, nbTiles)
	return null

static func AttractOrPushAway(targets:Array[Card], whoPos:Vector2i, nbTiles:int, attractOrPushAway:bool)->SecondaryEffect:
	for c in targets:
		var attractionVector = Vector2i(Vector2(whoPos - c.pos).normalized())
		if (!attractOrPushAway) : attractionVector = -attractionVector
		return Move(c, attractionVector, nbTiles)
	return null

static func RotateTowardsOrAway(targets:Array[Card], whoPos:Vector2i, nbTiles:int, towardsOrAway:bool)->SecondaryEffect:
	for c in targets:
		var lookVector = Vector2i(Vector2(whoPos - c.pos).normalized())
		if (!towardsOrAway) : lookVector = -lookVector
		return Rotate (c, Vector2(c.c_rotation).angle_to(lookVector))
	return null

static func BuffAll(targets:Array[Card], parameter:StringName, addedValue:int)->SecondaryEffect:
	for c in targets:
		return Buff(c, parameter, addedValue)
	return null

#endregion
