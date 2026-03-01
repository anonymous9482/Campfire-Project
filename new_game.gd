extends Button


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://Tutorial-Level.tscn")
	Globals.currentScene = "res://Tutorial-Level.tscn"
