extends Label

var base_text = "Health"

func _ready() -> void:
	pass


func _on_Player_player_health_change(new_value: int) -> void:
	self.text = "%s: %d" % [base_text, new_value]
