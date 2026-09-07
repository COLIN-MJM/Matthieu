class_name GameStateManager
extends Node

var playspace : PlaySpace

static func calculate_control(p:PlaySpace)->void:
	for cs in p.allSlots.values():
		(cs as CardSlot).inT1control=false
		(cs as CardSlot).inT2control=false
	print("started bullshit")
	for cs in p.allSlots.values():
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
					(cs as CardSlot).inT1control=true
				2:
					b=false
					(cs as CardSlot).inT2control=true
			stdr=2
		else:continue
		var coo:Array[Vector2i]=[]
		for x in range(0,stdr+1):
			for y in range(0,stdr+1):
				coo.append_array([
					Vector2i(
					clamp((cs as CardSlot).coords.x+x,0,p.dimensions.x-1),
					clamp((cs as CardSlot).coords.y+y,0,p.dimensions.y-1)),
					Vector2i(
					clamp((cs as CardSlot).coords.x-x,0,p.dimensions.x-1),
					clamp((cs as CardSlot).coords.y+y,0,p.dimensions.y-1)),
					Vector2i(
					clamp((cs as CardSlot).coords.x+x,0,p.dimensions.x-1),
					clamp((cs as CardSlot).coords.y-y,0,p.dimensions.y-1)),
					Vector2i(
					clamp((cs as CardSlot).coords.x-x,0,p.dimensions.x-1),
					clamp((cs as CardSlot).coords.y-y,0,p.dimensions.y-1)),
				])
		if b:
			for vc in coo:
				p.allSlots[vc].inT1control=true
		else :
			for vc in coo:
				p.allSlots[vc].inT2control=true
