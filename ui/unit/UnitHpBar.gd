class_name UnitHpBar
extends Control

@onready
var progress_bar: TextureProgressBar = $ProgressBar
var animation_speed = 0.2

@onready
var name_label: Label = $Name

var tween: Tween

func initialize(unit: Unit):
	var health: Health = unit.get_resource(ResourceType.Enum.HEALTH)
	health.resource_value_changed.connect(health_changed)
	health.resource_maximum_value_changed.connect(max_health_changed)
	progress_bar.max_value = health.get_maximum_value()
	progress_bar.value = health.get_value()
	name_label.text = unit.get_alias()
	tween = create_tween()

func health_changed(_resource: UnitResource, new_value: int, change: int, _original_change: int) -> void:
	update_progress_bar(new_value, change)
	
func update_progress_bar(new_value: int, _old_value: int) -> void:
	tween.kill()
	tween = create_tween()
	tween.tween_property(progress_bar, 'value', new_value, animation_speed)
	tween.play()
	
func max_health_changed(_resource: UnitResource, new_value: int) -> void:
	progress_bar.max_value = new_value
	
	
