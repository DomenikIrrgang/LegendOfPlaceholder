class_name ExperienceBar
extends TextureProgressBar

var player: Player
var animation_speed: float = 0.2
var tween: Tween

var tooltip = load("res://ui/GameUI/Tooltip/text_tooltip.tscn")
var tooltip_instance

func initialize(_player: Player) -> void:
	player = _player
	player.experience_changed.connect(experience_changed)
	player.level_changed.connect(level_changed)
	update_bar()
	
func experience_changed(_amount: int) -> void:
	update_bar()
	
func level_changed(_level: int) -> void:
	update_bar()	
	
func update_bar() -> void:
	if player.get_level() < player.max_level:
		if tween:
			tween.stop()
		tween = create_tween()
		tween.tween_property(self, "value", player.current_experience(), animation_speed)
		tween.play()
		max_value = player.experience_needed_for_next_level()
	else:
		visible = false

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
