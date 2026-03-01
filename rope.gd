extends Node2D

##signal climbEntered
##signal climbExited

@export var player : Protagonist
@export var length : float = 1 ## Each block is 1/8 length
@export var setLengthCall : Callable = setLength
var instanceOfRope: int

func _ready() -> void:
	##climbEntered.connect(player.ropeEntered)
	#climbExited.connect(player.ropeExited)
	$Line.scale.y = length
	instanceOfRope = Globals.ropesPlaced
	Globals.ropesPlaced += 1

func setLength(newLength):
	$Line.scale.y = newLength

##func _on_line_body_entered(body: Node2D) -> void:
	##if body in get_tree().get_nodes_in_group("Protagonist"):
		##climbEntered.emit()

##func _on_line_body_exited(body: Node2D) -> void:
	##if body in get_tree().get_nodes_in_group("Protagonist"):
		##climbExited.emit()
