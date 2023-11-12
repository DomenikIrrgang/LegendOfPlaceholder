class_name HealthBar
extends TextureProgressBar

var animation_speed: float = 0.1

var tooltip = load("res://ui/GameUI/Tooltip/text_tooltip.tscn")
var tooltip_instance

func initialize(player: Player) -> void:
	var health = player.get_resource(ResourceType.Enum.HEALTH)
	health.resource_value_changed.connect(health_changed)
	health.resource_maximum_value_changed.connect(max_health_changed)
	max_value = health.get_maximum_value()
	value = health.get_value()

func health_changed(_resource: UnitResource, new_value: int, change: int, _original_change: int) -> void:
	update_progress_bar(new_value, change)
	
func update_progress_bar(new_value: int, _old_value: int) -> void:
	var tween = create_tween()
	tween.tween_property(self, 'value', new_value, animation_speed)
	tween.play()
	
func max_health_changed(_resource: UnitResource, new_value: int) -> void:
	max_value = new_value

func _on_mouse_entered():
	if tooltip_instance == null:
		tooltip_instance = tooltip.instantiate()
		add_child(tooltip_instance)
		tooltip_instance.global_position = get_parent().global_position
	tooltip_instance.show_text(str(value) + "/" + str(max_value))
	tooltip_instance.visible = true

func _on_mouse_exited():
	if tooltip_instance != null:
		tooltip_instance.visible = false
