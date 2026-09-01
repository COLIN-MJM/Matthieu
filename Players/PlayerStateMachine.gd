class_name PlayerStateMachine
extends Resource

static var playerState : PlayerState = null

func _ready() -> void :
	ChangeToState(null)

func _process() -> void :
	playerState.OnUpdate()

static func ChangeToState(state:PlayerState) -> void :
	if playerState != null :
		playerState.OnExit()
	playerState = state
	playerState.OnEnter()
	return
