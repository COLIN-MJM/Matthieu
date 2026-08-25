@abstract
class_name Carte
extends Resource
var direction : Vector2i = Vector2i(0,-1)
var position :Vector2i :
	get :
		return position
	set(value) :
		oldPosition = position
		position=value
var oldPosition : Vector2i
@export var ActivationType :GlobalCardEnum.ActivationTypes
var afterEffect =Callable(self,"AfterEffect")
var owner : int 
var sprite : DPITexture
var strenght : int
var cardNumber : int
func _init() -> void:
	cardNumber= self.get_script().get_global_name().erase(0,self.get_script().get_global_name().length()-2).to_int()

var carteRenderer : CarteRenderer
@abstract func Activate()->SecondaryEffect #do thing on the current card
@abstract func AfterEffect(entrance:Carte)->void#store the logic to do on other cards
