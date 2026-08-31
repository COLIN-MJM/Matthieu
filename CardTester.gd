class_name CardTester
extends Node2D

@export var cardRessource : Card
var rulesFiles : PackedStringArray = ResourceLoader.list_directory("res://Rules_Ressources/")
var cardsP1 : Array[Card]
var cardsP2 : Array[Card]

func _ready() -> void:
	for f in range(rulesFiles.size()):
		var ruleResource : Rule = load(ResourceUID.path_to_uid("res://Rules_Ressources/" + rulesFiles[f])) as Rule
		cardsP1.append(InstantiateCard(ruleResource, true))
		cardsP2.append(InstantiateCard(ruleResource, false))
	
	for c in cardsP1:
		print(c.c_owner)
		print(c.rule.rawFilters[0])
	
	for c in cardsP2:
		print(c.c_owner)
		print(c.rule.rawFilters[0])

func InstantiateCard(rule:Rule, team:bool)->Card:
	var newCard : Card = cardRessource.duplicate()
	newCard.rule = rule
	newCard.rule.bindedCard = newCard
	if team : return newCard
	newCard.c_owner = false
	return newCard
