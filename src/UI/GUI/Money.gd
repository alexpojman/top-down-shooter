extends Label

var base_text = "Money"

func _ready() -> void:
	pass


func _on_Player_money_change(new_value: int) -> void:
	self.text = "%s: %d" % [base_text, new_value]
