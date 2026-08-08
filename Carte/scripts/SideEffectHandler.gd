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
	effectQueu.free()

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
	
	func first ()->SecondaryEffect :
		var index = qeu.find_custom(func(x:SecondaryEffect) : return !x.wasEvaluated)
		qeu[index].wasEvaluated= true
		return qeu[index]
	
	func _init(initial : SecondaryEffect) -> void:
		qeu = [initial]
	func queu_secondaryEffect(SE : SecondaryEffect)->void :
		qeu.push_back(SE)
	func havefinished()->bool :
		return qeu.filter(func(x : SecondaryEffect): return !x.wasEvaluated).is_empty()
