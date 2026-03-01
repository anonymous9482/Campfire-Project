extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Monster body/Monster sprite".play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_monster_collider_body_entered(body: Node2D) -> void:
	print("Body Entered: " + str(body))
	if body in get_tree().get_nodes_in_group("Protagonist"):
		get_tree().change_scene_to_file("res://death_screen.tscn")
