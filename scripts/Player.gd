extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

var velocity = Vector3.ZERO


	
func _input(event):
	if event is InputEventMouseMotion:
		$Camera.rotation_degrees.y -= clamp(event.relative.x * 0.5, -5.0, 5.0)
		$Camera.rotation_degrees.x -= clamp(event.relative.y * 0.5, -5.0, 5.0)
		self.transform = $Camera.transform
	
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_backward"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		
	if Input.is_action_just_pressed("jump"):
		direction.y -= 5

	if direction != Vector3.ZERO:
		direction = direction.normalized()

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y -= fall_acceleration
	velocity = move_and_slide(velocity, Vector3.UP)	
