class_name PlaySpace
extends Node3D
@export var dimensions : Vector2i
@export var cam :Camera3D
var slotSize : Vector2
@export var player_manager : Player_Manager
@export_custom(PROPERTY_HINT_RANGE,"0,4,1") var nbr_of_player : int
var board : Node3D
var TlMidBr : PackedVector2Array
@onready var cardSlot : PackedScene =$".".get_meta("cardSlot")

var scaler : Vector2 
var lowerBound : Vector2
var upperBound : Vector2
var pixel_size : Vector2

#var sideEffectHandler : SideEffectHandler = SideEffectHandler.new(self)

var allSlots :Dictionary[Vector2i,CardSlot]

func _ready() -> void:
	scaler= Vector2(slotSize)/100
	createGrid()
	positionCam()
	for cs in allSlots.values():
		(cs as CardSlot).done()
	lowerBound =allSlots[Vector2i(0,0)].screen_coords.lower_point
	upperBound =allSlots[dimensions-Vector2i(1,1)].screen_coords.upper_point
	pixel_size=allSlots[Vector2i(0,0)].screen_coords.upper_point
	pixel_size = abs(lowerBound-pixel_size)
	create_base()


func create_base()->void:
	var twenyCentX : int =clampi(floori(dimensions.x * 0.2),3,floori(dimensions.x * 0.2))
	var twenyCentY : int =clampi(floori(dimensions.y * 0.2),3,floori(dimensions.y * 0.2))
	
	allSlots[Vector2i(twenyCentX,twenyCentY)].isBase=1
	allSlots[Vector2i(dimensions.x-twenyCentX-1,twenyCentY)].isBase=1
	allSlots[Vector2i(twenyCentX,dimensions.y-twenyCentY-1)].isBase=2
	allSlots[Vector2i(dimensions.x-twenyCentX-1,dimensions.y-twenyCentY-1)].isBase=2
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left mouse Clic") : test_click_to_slot(event)

func positionCam()->void :
	var height :float = (slotSize*Vector2(dimensions)).length_squared()/2*tan(cam.fov/4)
	cam.position=Vector3(slotSize.x*dimensions.x/2,slotSize.y*dimensions.y/2,-height)
func createGrid()->void:
	board=Node3D.new()
	add_child(board)
	
	for y in dimensions.y :
		for x in dimensions.x :
			var instance : CardSlot = cardSlot.instantiate()
			instance.total_pixelsize=instance.texture.get_size()*instance.pixel_size
			slotSize=instance.total_pixelsize
			instance.position = Vector3(slotSize.x * x,slotSize.y * y,0 )
			instance.coords = Vector2i(x,y)
			allSlots[Vector2i(x,y)] = instance
			board.add_child(instance)
func test_click_to_slot(event : InputEventMouseButton)->void :
	var b : bool =event.position.x>=lowerBound.x and event.position.x<=upperBound.x and event.position.y<=lowerBound.y and event.position.y>=upperBound.y
	if !b : return
	var mousePos :Vector2= event.position-lowerBound
	var test : Vector2i = Vector2i( floori(mousePos.x /pixel_size.x) ,abs(floori(mousePos.y /pixel_size.y))-1)
	print(test)
func Resolve_AttacksAndDefend()->void :
	var slotWithCard = allSlots.values().filter(
		func(x : CardSlot): return x.haveCarte)
	for slot : CardSlot in slotWithCard :
		var tryPos : Vector2i =slot.coords+slot.carteData.direction
		if tryPos.x <dimensions.x and tryPos.x >0 and tryPos.y <dimensions.y and tryPos.y >0  :
			allSlots[tryPos].combat_score+=slot.carteData.strenght
		
	
func Resolve_Passive()->void :
	var filtered =allSlots.keys().filter(
		func(x:Vector2i) :
			return (allSlots[x].haveCarte and allSlots[x].carteData.ActivationType== GlobalCardEnum.ActivationTypes.Passive)
	)
	
	#for y in filtered :
		#sideEffectHandler.queu_secondaryEffect(allSlots[y].ActivateCard())
	#sideEffectHandler.ResolveSecondaryEffects()

func debugCreateCard(at :Vector2i =Vector2i(0,0))->void :
	var ressource : PackedScene = preload("res://CarteInstance.tscn")
	var instance : CardRenderer =ressource.instantiate()
	instance.CardEffect.direction=Vector2i.RIGHT
	allSlots[at].AssignCard(instance)
	
