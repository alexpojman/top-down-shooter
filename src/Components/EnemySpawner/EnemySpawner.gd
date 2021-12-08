extends Position2D

var enemy = preload("res://src/Actors/Enemy/enemy.tscn")
var timer

func _ready() -> void:
	timer = get_node("Timer")
	timer.set_wait_time(0.25)
	timer.connect("timeout", self, "_on_Timer_timeout")

func _on_Timer_timeout():
	var instance = enemy.instance();
	get_tree().get_root().add_child(instance)
	instance.position = position

	timer.set_wait_time(2.0)
	