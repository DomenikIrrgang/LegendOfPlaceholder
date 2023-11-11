class_name SystemMessage
extends CenterContainer

@onready
var message_label: Label = $Message

@export
var message_duration: float = 3.5

var tween: Tween

func _ready() -> void:
	BossEncounter.boss_encounter_started.connect(on_encounter_started)
	BossEncounter.boss_encounter_defeated.connect(on_encounter_defeated)
	SceneSwitcher.zone_loaded.connect(on_zone_loaded)

func initialize(player: Player) -> void:
	message_label.text = ""
	player.level_changed.connect(on_player_level_changed)
	
func on_zone_loaded(zone: Zone) -> void:
	show_system_message(zone.zone_name)

func show_system_message(message: String) -> void:
	if tween:
		tween.stop()
	message_label.text = message
	message_label.modulate.a = 1.0
	tween = create_tween()
	tween.tween_property(message_label, "modulate", Color(message_label.modulate.r, message_label.modulate.g, message_label.modulate.b, 0.0), message_duration).set_ease(Tween.EASE_IN)
	tween.play()
	visible = true
	
func on_encounter_started(boss: Unit) -> void:
	show_system_message("Defeat " + boss.get_alias() + "!")	
	
func on_encounter_defeated() -> void:
	show_system_message("Congratulations!")	
	
func on_player_level_changed(level: int) -> void:
	print("Level Changed to", level)
	show_system_message("You reached level " + str(level) + "!")
