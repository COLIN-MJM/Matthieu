@abstract
class_name Carte
extends Resource
var direction : Vector2i
var position :Vector2i
var ActivationType :GlobalCardEnum.ActivationTypes
var afterEffect =Callable(self,"AfterEffect")
var wasEvaluated : bool =false


@abstract func Activate()->SecondaryEffect #do thing on the current card
@abstract func AfterEffect(entrance:Carte)->void#store the logic to do on other cards
