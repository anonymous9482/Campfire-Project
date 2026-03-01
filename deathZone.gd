extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("Protagonist"):
		get_tree().change_scene_to_file("res://death_screen.tscn")
