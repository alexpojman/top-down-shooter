extends KinematicBody2D

export var move_speed: int = 4.0;

var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_vector.x = 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x = -1
	if Input.is_action_pressed("ui_up"):
		input_vector.y = -1
	if Input.is_action_pressed("ui_down"):
		input_vector.y = 1
		
	move_and_collide(input_vector.normalized() * move_speed)
