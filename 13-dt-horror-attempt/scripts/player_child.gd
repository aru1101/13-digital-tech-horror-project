extends CharacterBody3D


const SPEED = 1.5
const JUMP_VELOCITY = 4.5

var mouse_sensitivity = 0.002

@export_group("headbob")
@export var headbob_frequency := 4.0
@export var headbob_ampltiude := 0.07
var headbob_time := 0.0

var footstep_can_play := true
var footstep_landed


func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$head/Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$head/Camera3D.rotation.x = clampf($head/Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	headbob_time += delta * velocity.length() * float(is_on_floor())
	%Camera3D.transform.origin = headbob(headbob_time)
	
	if not footstep_landed and is_on_floor(): # Landed
		%FootstepAudio3D.play()
	footstep_landed = is_on_floor()


func headbob(headbob_time):
	var headbob_position = Vector3.ZERO
	headbob_position.y = sin(headbob_time * headbob_frequency) * headbob_ampltiude
	headbob_position.x = sin(headbob_time * headbob_frequency / 2) * headbob_ampltiude
	
	var footstep_threshold = -headbob_ampltiude + 0.002
	if headbob_position.y > footstep_threshold:
		footstep_can_play = true
	elif headbob_position.y < footstep_threshold and footstep_can_play:
		footstep_can_play = false
		%FootstepAudio3D.play()
	
	return headbob_position
