extends Area2D

export var bullet_speed: int = 600
onready var direction = (get_global_mouse_position() - get_tree().get_current_scene().get_node("Player").global_position).normalized()

func _ready() -> void:
	position = get_tree().get_current_scene().get_node("Player").position
	
func _physics_process(delta: float) -> void:
	
	position += bullet_speed * delta * direction


func _on_Bullet_body_entered(body: Node) -> void:
	if (body.is_in_group("Enemy")):
		body.die()
		queue_free()
