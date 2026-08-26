@tool
class_name RulesCreator
extends EditorScript

var window : Window
var gui := preload("uid://bhfq52js8fsv")

func _run() -> void:
	window = Window.new()
	window.title = "Rules Creator"
	
	var gui_scene := gui.instantiate()
	window.add_child(gui_scene)
	gui_scene.confirmed.connect(_on_confirmed)
	
	var screenSize : Vector2i = DisplayServer.screen_get_size()
	EditorInterface.popup_dialog(window, Rect2i(screenSize/2, Vector2i(300, 300)))
	window.close_requested.connect(func():
		window.queue_free()
	)

func _on_confirmed(text : String):
	print (text)
	
