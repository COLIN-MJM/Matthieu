class_name La_Main
extends Control

@export var allCarte : AllCarte
@export var deathCD: int

var currentSelected : int = -1

enum CarteState{IN_HAND,IN_CEMETARY,IN_PLAY,IN_PILE}

var allCarteState :Dictionary[int, CarteState]
var carteCemetary : Dictionary[int,int]
func _ready() -> void:
	var numberOfCarte : Array [int] = allCarte.dico.keys()
	for x in numberOfCarte :
		allCarteState[x]=CarteState.IN_HAND
		allCarte.add_item(String.num(x))
		


func requestCard(i :int)->Carte :
	if allCarteState[i] == CarteState.IN_HAND :
		allCarteState[i] = CarteState.IN_PLAY
		currentSelected = -1
		return allCarte.GetCarteInstanceOnNumber(i)
	else :
		push_warning("Already used Carte")
		return null

func decreaseDeathTimer()->void :
	for c : int  in carteCemetary:
		carteCemetary[c]-=1
	var zeroCemElement : Array[int] =carteCemetary.keys().filter(func(x : int) : return carteCemetary[x]<=0)
	for k : int in zeroCemElement:
		allCarteState[k]=CarteState.IN_HAND
		carteCemetary.erase(carteCemetary[k])


func _on_item_list_item_selected(index: int) -> void:
	currentSelected= allCarte.get_item_text(index).to_int()
