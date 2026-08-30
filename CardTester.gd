class_name CardTester
extends Node2D

var files : PackedStringArray = ResourceLoader.list_directory("res://NewCards/")
var cards : Array[Card]

func _ready() -> void:
	for f in range(files.size()):
		var uid : String
		uid = ResourceUID.path_to_uid("res://NewCards/" + files[f])
		cards.append(load(uid))
