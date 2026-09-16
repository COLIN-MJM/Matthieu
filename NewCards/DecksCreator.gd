class_name DecksCreator
extends Node

@export var playerManager : NewPlayer
var cardScene : PackedScene = preload("uid://cqhllnaq53hyr")
var rulesFiles : PackedStringArray = ResourceLoader.list_directory("res://Rules_Ressources/")
var cardsP1 : Array[Card]
var cardsP2 : Array[Card]

func _ready() -> void:
	for f in range(rulesFiles.size()):
		var ruleResource : Rule = load(ResourceUID.path_to_uid("res://Rules_Ressources/" + rulesFiles[f])) as Rule
		cardsP1.append(CreateCard(ruleResource, true))
		cardsP2.append(CreateCard(ruleResource, false))
	playerManager.remainingDeckP1 = cardsP1
	playerManager.remainingDeckP2 = cardsP2

func CreateCard(rule:Rule, team:bool)->Card:
	var newCard := cardScene.instantiate() as Card
	newCard.c_init(rule, team)
	newCard.rule.bindedCard = newCard
	add_child.call_deferred(newCard)
	return newCard
