extends Area2D

class_name RecoverableRemains

# Signals
signal remains_collected(amount);

# Variables
var timer
var recoverable_amount: int = 1000


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = get_node("Timer")
	timer.set_wait_time(0.25)
	timer.connect("timeout", self, "_on_Timer_timeout")

func _on_RecoverableRemains_body_entered(body:Node) -> void:
	if (body.is_in_group("Player")):
		emit_signal("remains_collected", recoverable_amount)
		queue_free()
		
func _on_Timer_timeout():
	print("Timeout")
	$CollisionShape2D.set_deferred("disabled", false)

