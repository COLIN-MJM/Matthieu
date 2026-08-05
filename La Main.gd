class_name La_Main
extends Control

@export var allCarte : AllCarte
@export var selectable : ItemList

var currentSelected : int = -1

enum CarteState{IN_HAND,IN_CEMETARY,IN_PLAY,IN_PILE}

var allCarteState :Dictionary[int, CarteState]

func _ready() -> void:
	var numberOfCarte : Array [int] = allCarte.dico.keys()
	for x in numberOfCarte :
		allCarteState[x]=CarteState.IN_HAND
		selectable.add_item(String.num(x))


func requestCard(i :int)->Carte :
	if allCarteState[i] == CarteState.IN_HAND :
		allCarteState[i] = CarteState.IN_PLAY
		currentSelected = -1
		return allCarte.GetCarteInstanceOnNumber(i)
	else :
		push_warning("Already used Carte")
		return null


func _on_item_list_item_selected(index: int) -> void:
	currentSelected= selectable.get_item_text(index).to_int()
