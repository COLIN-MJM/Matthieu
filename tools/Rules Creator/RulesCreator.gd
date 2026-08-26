@tool
class_name RulesCreator
extends EditorScript

var window : Window

func _run() -> void:
	window = Window.new()
	window.title = "Rules Creator"
	var screenSize : Vector2i = DisplayServer.screen_get_size()
	EditorInterface.popup_dialog(window, Rect2i(screenSize/2, Vector2i(300, 300)))
	window.close_requested.connect(func():
		window.queue_free()
	)
