extends Area2D

export var value: int = 5

func _ready() -> void:
	pass


func _on_CoinPickup_body_entered(body:Node) -> void:
	if (body.is_in_group("Player")):
		body.add_money(value)
		queue_free()
