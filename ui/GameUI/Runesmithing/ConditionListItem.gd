extends MarginContainer

@onready
var condition_text: Label = $VBoxContainer/Label

var condition: Condition

func _ready() -> void:
	visibility_changed.connect(on_visibility_changed)
	
func on_visibility_changed() -> void:
	set_condition(condition)

func set_condition(_condition: Condition) -> void:
	condition = _condition
	condition_text.text = condition.get_string()
	if condition.is_fulfilled():
		condition_text.self_modulate = Color.GREEN
	else:
		condition_text.self_modulate = Color.RED
