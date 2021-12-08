extends KinematicBody2D
class_name Player

# Signals
signal player_died(position)

# Preloads
var recoverable_remains = preload("res://src/Actors/RecoverableRemains/RecoverableRemains.tscn")
var bullet = preload("res://src/Actors/Bullet/Bullet.tscn")

# Public Vars
export var move_speed: int = 4
export var run_speed: int = 6
export var max_health: int = 10
export var current_health: int = 10
export var current_money: int = 0

var velocity: Vector2 = Vector2.ZERO
var start_position: Vector2;

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	start_position = get_parent().get_node("PlayerStartPosition").position
	position = start_position

func _process(_delta: float) -> void:
	$Reticle.global_position = get_global_mouse_position()

func _physics_process(_delta: float) -> void:
	
	var input_vector = Vector2.ZERO
	var speed = move_speed

	if Input.is_action_pressed("ui_right"):
		input_vector.x = 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x = -1
	if Input.is_action_pressed("ui_up"):
		input_vector.y = -1
		$AnimatedSprite.play("walk_up")
	if Input.is_action_pressed("ui_down"):
		input_vector.y = 1
		$AnimatedSprite.play("walk_down")

	if Input.is_action_pressed("run"):
		speed = run_speed
	
	# warning-ignore:return_value_discarded
	move_and_collide(input_vector.normalized() *speed)
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func damage(amount: int) -> int:
	current_health -= amount

	if (current_health <= 0):
		die()

	return current_health

func die() -> void:
	emit_signal("player_died", self.global_position)
	respawn()
	

func add_money(amount: int) -> void:
	current_money += amount
	print("Current money: %d" % current_money)

func respawn() -> void:
	var death_position = position
	position = start_position
	current_health = max_health

	remove_existing_remains()
	
	var remains = recoverable_remains.instance()
	remains.position = death_position
	get_tree().get_root().call_deferred("add_child", remains)
	remains.recoverable_amount = current_money
	remains.connect("remains_collected", self, "_on_RecoverableRemains_remains_collected")

	current_money = 0


func _on_RecoverableRemains_remains_collected(amount: int) -> void:
	add_money(amount)
	
func remove_existing_remains() -> void:
	var existing_remains = get_tree().get_nodes_in_group("remains")

	for child in existing_remains:
		child.queue_free()
		
func shoot() -> void:
	var instanced_bullet = bullet.instance()
	get_tree().get_root().add_child(instanced_bullet)


func _on_Hitbox_body_entered(body: Node) -> void:
	if (body.is_in_group("Enemy")):
		print("I'm hit!")
