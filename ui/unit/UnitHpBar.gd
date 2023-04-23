class_name UnitHpBar
extends Control

@onready
var progress_bar: TextureProgressBar = $ProgressBar
var animation_speed = 0.2

@onready
var name_label: Label = $Name

func initialize(unit: Unit):
	unit.health_changed.connect(health_changed)
	progress_bar.max_value = unit.max_health
	progress_bar.value = unit.health
	name_label.text = unit.alias
	name_label.position.x = -((name_label.size.x * name_label.scale.x) / 2)
	
func health_changed(new_value: int, change: int) -> void:
	update_progress_bar(new_value, change)
	
func update_progress_bar(new_value: int, _change: int) -> void:
	var tween = create_tween()
	tween.tween_property(progress_bar, 'value', new_value, animation_speed)
	tween.play()
	
	
