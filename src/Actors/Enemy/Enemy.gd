extends KinematicBody2D

var coin_pickup = preload("res://src/Actors/CoinPickup/CoinPickup.tscn")

export var move_speed: int = 100
export var damage_amount: int = 2;

var _velocity: Vector2 = Vector2.ZERO
var _player: Player = null

func _ready() -> void:
	move_speed = move_speed * rand_range(0.7, 1.0)
	
func _physics_process(_delta: float) -> void:
	_velocity = Vector2.ZERO
	
	if _player:
		_velocity = position.direction_to(_player.position) * move_speed
	
	_velocity = move_and_slide(_velocity)


func _on_PlayerDetectionRange_body_entered(body: Node) -> void:
	if (body.is_in_group("Player")):
		_player = body
		


func _on_PlayerDetectionRange_body_exited(body: Node) -> void:
	if (body.is_in_group("Player")):
		_player = null


func _on_Hitbox_body_entered(body: Node) -> void:
	if (body.is_in_group("Player")):
		var player = body as Player
		player.damage(damage_amount)

func die() -> void:
	var coin_instance = coin_pickup.instance()
	get_tree().get_root().add_child(coin_instance)
	coin_instance.position = position
	queue_free()
