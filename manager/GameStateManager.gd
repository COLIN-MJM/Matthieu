class_name GameStateManager
extends Node

@export var playspace : PlaySpace
const CardScene:PackedScene=preload("uid://cqhllnaq53hyr")
var allInPlayCard : Array[Card]

func InstantiateCard(b:bool,r:Rule,c:Vector2i)->Card:
	var card:=CardScene.instantiate() as Card
	card.c_init(r,b,c)
	playspace.allSlots[c].AddCard(card)
	allInPlayCard.append(card)
	return card

func MoveCard(c:Card , target :Vector2i)->void :
	playspace.allSlots[c.c_position].RemoveCard()
	playspace.allSlots[target].AddCard(c)
	
func RemoveCard(c:Card)->void:
	allInPlayCard.erase(c)
	playspace.allSlots[c.c_position].RemoveCard()
	c.free()

func calculate_control()->void:
	for cs in playspace.allSlots.values():
		var stdr:int
		var b : bool
		if (cs as CardSlot).haveCard :
			b =(cs as CardSlot).cardData.c_owner
			if b:(cs as CardSlot).inT1control=true
			else :(cs as CardSlot).inT2control=true
			stdr =(cs as CardSlot).cardData.parameters[&"Zoc"]
		elif (cs as CardSlot).isBase!=0 and (cs as CardSlot).isBase!=null :
			match (cs as CardSlot).isBase:
				1:
					b=true
					
				2:
					b=false
					
			stdr=2
		else:continue
		var coo:Array[Vector2i]=[]
		for x in range(0,stdr+1):
			for y in range(0,stdr+1):
				coo.append_array([
					Vector2i(
					clamp((cs as CardSlot).coords.x+x,0,playspace.dimensions.x-1),
					clamp((cs as CardSlot).coords.y+y,0,playspace.dimensions.y-1)),
					Vector2i(
					clamp((cs as CardSlot).coords.x-x,0,playspace.dimensions.x-1),
					clamp((cs as CardSlot).coords.y+y,0,playspace.dimensions.y-1)),
					Vector2i(
					clamp((cs as CardSlot).coords.x+x,0,playspace.dimensions.x-1),
					clamp((cs as CardSlot).coords.y-y,0,playspace.dimensions.y-1)),
					Vector2i(
					clamp((cs as CardSlot).coords.x-x,0,playspace.dimensions.x-1),
					clamp((cs as CardSlot).coords.y-y,0,playspace.dimensions.y-1)),
				])
		coo =coo.filter(func(x:Vector2i) : return x!=(cs as CardSlot).coords )
		if b:
			for vc in coo:
				playspace.allSlots[vc].inT1control=true
		else :
			for vc in coo:
				playspace.allSlots[vc].inT2control=true
