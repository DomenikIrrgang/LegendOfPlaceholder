class_name UnitFramePlayer
extends Control

@onready
var health_bar: TextureProgressBar = $HealthBar

@onready
var current_health_label: Label = $CurrentHealth

@onready
var max_health_label: Label = $MaxHealth

var animation_speed: float = 0.1

func initialize(player: Player) -> void:
	player.health.resource_value_changed.connect(health_changed)
	player.health.resource_maximum_value_changed.connect(max_health_changed)
	health_bar.max_value = player.health.get_maximum_value()
	health_bar.value = player.health.get_value()
	current_health_label.text = str(health_bar.value)
	max_health_label.text = "/" + str(health_bar.max_value)
	
func _process(_delta: float) -> void:
	current_health_label.text = str(health_bar.value)	

func health_changed(new_value: int, change: int) -> void:
	update_progress_bar(new_value, change)
	
func update_progress_bar(new_value: int, _old_value: int) -> void:
	var tween = create_tween()
	tween.tween_property(health_bar, 'value', new_value, animation_speed)
	tween.play()
	
func max_health_changed(new_value: int, _old_value: int) -> void:
	health_bar.max_value = new_value
	max_health_label.text = "/" + str(health_bar.max_value)	
