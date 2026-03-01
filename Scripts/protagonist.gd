class_name Protagonist extends CharacterBody2D


@export var SPEED = 75.0
const JUMP_VELOCITY = -175.0

var falling = true;
var floating = false;

var hasTorch = true;

var inRope = false;
var holdingRope = false;

var onFloor : bool

@export var ropeFriction = 500

func _physics_process(delta: float) -> void:
	onFloor = is_on_floor()
	
	handle_gravity(delta);

	if (inRope):
		onFloor = true
		##print("should be on rope")
		if (Input.is_action_pressed("Use Rope")):
			if !(Input.is_action_pressed("Climb Down") || Input.is_action_pressed("Climb Up")):
				velocity.y = move_toward(velocity.y,0,200*delta)
			else:
				if (Input.is_action_pressed("Climb Up")):
					velocity.y = SPEED/-2 ##move_toward(velocity.y,SPEED/2,100*delta);
					print("climbing down")
				if (Input.is_action_pressed("Climb Down")):
					velocity.y = SPEED/2 ##move_toward(velocity.y,SPEED/-2,100*delta);
					print("climbing up")
			holdingRope = true;
		else:
			holdingRope = false;
			
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func handle_gravity(delta: float): 
	if !onFloor:
		if velocity.y <= 0:
			velocity += get_gravity() * delta;
		if !floating:
			floating = true;
			$CoyoteTimer.start();
			if !holdingRope:
				velocity += get_gravity() * delta * 0.01;
				print("Slowly going down")
	else:
		falling = false;
		floating = false;
	if falling:
		if (!holdingRope):
			print("Falling")
			velocity += get_gravity() * delta;


func _on_coyote_timer_timeout() -> void:
	falling = true;

func gainTorch(energy: float):
	$Torch/PointLight2D.energy = energy
	$"Torch/Burning Out".start()



func _on_rope_detector_area_entered(area: Area2D) -> void:
	print("Entered")
	if area in get_tree().get_nodes_in_group("Rope"):
		print(" and recieved")
		inRope = true;


func _on_rope_detector_area_exited(area: Area2D) -> void:
	print("Exited")
	if area in get_tree().get_nodes_in_group("Rope"):
		print(" and left")
		inRope = false;
		falling = !is_on_floor()
		holdingRope = false

func _process(delta: float):
	if (is_on_floor() && velocity.x != 0 && !$Sprite2D.is_playing()):
		$Sprite2D.play("PlayerNoTorchRun")
	else: 
		$Sprite2D.set_frame_and_progress(0,0.0);
