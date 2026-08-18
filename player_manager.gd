class_name  Player_Manager
extends Control

@export var playspace : PlaySpace
@export var text : Label
@onready var player_scene : PackedScene =$".".get_meta("Player_Scene")
var players : Array[Player]
var currRound : int 

var current_player : int  = 0

func _ready() -> void:
	positionText()
	get_window().size_changed.connect(positionText)

var isInTurn :bool
func _process(delta: float) -> void:
	if !isInTurn : await setup_turn()
	else : pass

func positionText() -> void:
	var wind : Window = get_window()
	text.position=Vector2i(wind.size.x/2,0)
	text.size=Vector2(wind.size.x*0.15,wind.size.x*0.15)

func setup_turn() ->void:
	isInTurn=true
	await _process_round()
	currRound +=1
	isInTurn=false


func  _process_round()->bool :
	for p in players :
		current_player= p.player_Id
		text.text=" round "+ str(currRound)+"\n"+"player to play "+ str(current_player)
		await _process_turn(p)
	return true

func _process_turn(player : Player)->bool :
	playspace.Resolve_Passive()
	player.isTurn=true
	await player.turnSuccessFull
	player.isTurn=false
	playspace.sideEffectHandler.ResolveSecondaryEffects()
	return true

func createplayer_sceneS(nbrP : int) ->void :
	var playerId : int
	for i in range(nbrP) :
		if i ==0 : 
			playerId = 1
			createplayer_scene(playerId)
		else : 
			if i%2!=0: 
				createplayer_scene(playerId*-1)
			else : 
				playerId +=1
				createplayer_scene(playerId)

func createplayer_scene(p_id : int)->void:
	var player : Player = player_scene.instantiate()
	player.playSpace= get_parent() as PlaySpace
	player.player_Id=p_id
	player.isTurn=false
	players.append(player)
	add_child(player)
	player._setup_listVisual()
