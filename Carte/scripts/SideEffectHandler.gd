class_name  SideEffectHandler
extends Object

func _init(pS : PlaySpace) -> void:
	playSpace=pS

var playSpace :PlaySpace

var effectQueu : EffectQueu

func ResolveSecondaryEffects() -> void :
	if effectQueu == null : return
	while !effectQueu.havefinished() :
		applySecondaryEffects(effectQueu.first())

func queu_secondaryEffect(SE : SecondaryEffect)->void :
	if effectQueu == null :
		effectQueu= EffectQueu.new(SE)
	else :
		effectQueu.queu_secondaryEffect(SE)

func applySecondaryEffects(entrance : SecondaryEffect)->void :
	for x :Vector2i in entrance.targetsCoords:
		if playSpace.allSlots[x].carte :
			entrance.effectToDo.call(playSpace.allSlots[x].carteData)

class EffectQueu :
	var qeu :Array[SecondaryEffect]
	var last_first : int 
	
	func first ()->SecondaryEffect :
		var index = qeu.find_custom(func(x:SecondaryEffect) : return !x.wasEvaluated ,last_first)
		qeu[index].wasEvaluated= true
		last_first=index
		return qeu[index]
	
	func _init(initial : SecondaryEffect) -> void:
		qeu = [initial]
	func queu_secondaryEffect(SE : SecondaryEffect)->void :
		qeu.push_back(SE)
	func havefinished()->bool :
		return qeu.filter(func(x : SecondaryEffect): return !x.wasEvaluated).is_empty()
