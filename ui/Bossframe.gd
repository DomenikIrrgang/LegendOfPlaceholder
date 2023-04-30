class_name BossFrame
extends Control

@onready
var health_bar: TextureProgressBar = $CenterContainer/FrameTexture/HealthBar

@onready
var boss_level_label: Label = $CenterContainer/FrameTexture/CenterLevel/BossLevel

@onready
var boss_name_label: Label = $CenterContainer/FrameTexture/CenterName/BossName

@onready
var boss_health_label: Label = $CenterContainer/FrameTexture/HealthBar/CenterHealthText/BossHealth

func _ready():
	BossEncounter.boss_encounter_started.connect(on_encounter_started)
	BossEncounter.boss_encounter_ended.connect(on_encounter_ended)
	visible = false
	
func on_encounter_started(boss: Unit) -> void:
	boss_level_label.text = str(boss.get_level())
	boss_name_label.text = boss.get_alias()
	health_bar.max_value = boss.get_resource(ResourceType.Enum.HEALTH).get_maximum_value()
	health_bar.value = boss.get_resource(ResourceType.Enum.HEALTH).get_value()
	boss_health_label.text = str(boss.get_resource(ResourceType.Enum.HEALTH).get_value()) + " / " + str(boss.get_resource(ResourceType.Enum.HEALTH).get_maximum_value())
	boss.get_resource(ResourceType.Enum.HEALTH).resource_value_changed.connect(on_boss_health_changed)
	boss.get_resource(ResourceType.Enum.HEALTH).resource_maximum_value_changed.connect(on_boss_max_health_changed)
	visible = true
	
func on_boss_health_changed(resource: UnitResource, _new_value: int, _change: int, _original_change: int) -> void:
	var tween = create_tween()
	tween.tween_property(health_bar, "value", resource.get_value(), 0.2)
	boss_health_label.text = str(resource.get_value()) + " / " + str(resource.get_maximum_value())	
	
func on_boss_max_health_changed(resource: UnitResource, _new_maximum_value: int) -> void:
	health_bar.value = resource.get_maximum_value()
	boss_health_label.text = str(resource.get_value()) + " / " + str(resource.get_maximum_value())		
	
func on_encounter_ended() -> void:
	visible = false
