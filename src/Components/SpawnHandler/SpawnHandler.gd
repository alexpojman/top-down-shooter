extends Node2D

var recoverable_remains = preload("res://src/Actors/RecoverableRemains/RecoverableRemains.tscn")

func _ready() -> void:
	pass


func _on_Player_player_died(position: Vector2) -> void:
	print("died")
	remove_existing_remains()

	var remains = recoverable_remains.instance()
	get_tree().get_root().add_child(remains)
	remains.global_position = position



func remove_existing_remains() -> void:
	var desired_children = get_tree().get_nodes_in_group("remains")

	for child in desired_children:
		child.queue_free()
