class_name BossFrame
extends Control

@onready
var health_bar: TextureProgressBar = $Frame/FrameTexture/HealthBar

@onready
var boss_level_label: Label = $Frame/FrameTexture/CenterLevel/BossLevel

@onready
var boss_name_label: Label = $Frame/FrameTexture/CenterName/BossName

@onready
var boss_health_label: Label = $Frame/FrameTexture/HealthBar/BossHealth/Label

@onready
var boss_health_percentage_label: Label = $Frame/FrameTexture/HealthBar/BossHealthPercenate/Label

@onready
var castbar: Castbar = $Castbar

@onready
var buffs: StatusEffectBar = $Buffs

@onready
var debuffs: StatusEffectBar = $Debuffs

var tween: Tween

func _ready():
	BossEncounter.boss_encounter_started.connect(on_encounter_started)
	BossEncounter.boss_encounter_ended.connect(on_encounter_ended)
	visible = false
	tween = create_tween()
	
func on_encounter_started(boss: Unit) -> void:
	boss_level_label.text = str(boss.get_level())
	boss_name_label.text = boss.get_alias()
	health_bar.max_value = boss.get_resource(ResourceType.Enum.HEALTH).get_maximum_value()
	health_bar.value = boss.get_resource(ResourceType.Enum.HEALTH).get_value()
	boss_health_label.text = get_boss_health_string(boss.get_resource(ResourceType.Enum.HEALTH))
	boss_health_percentage_label.text = get_boss_health_percentage_string(boss.get_resource(ResourceType.Enum.HEALTH))
	boss.get_resource(ResourceType.Enum.HEALTH).resource_value_changed.connect(on_boss_health_changed)
	boss.get_resource(ResourceType.Enum.HEALTH).resource_maximum_value_changed.connect(on_boss_max_health_changed)
	castbar.initialize(boss)
	buffs.initialize(boss)
	debuffs.initialize(boss)
	visible = true
	
func get_boss_health_string(resource: UnitResource) -> String:
	return str(resource.get_value()) + " / " + str(resource.get_maximum_value())
	
func get_boss_health_percentage_string(resource: UnitResource) -> String:
	return str(snapped(float(resource.get_value()) / float(resource.get_maximum_value()) * 100, 0.1)) + "%"
	
func on_boss_health_changed(resource: UnitResource, _new_value: int, _change: int, _original_change: int) -> void:
	tween.kill()
	tween = create_tween()
	tween.tween_property(health_bar, "value", resource.get_value(), 0.2)
	tween.play()
	boss_health_label.text = get_boss_health_string(resource)
	boss_health_percentage_label.text = get_boss_health_percentage_string(resource)
	
func on_boss_max_health_changed(resource: UnitResource, _new_maximum_value: int) -> void:
	health_bar.max_value = resource.get_maximum_value()
	boss_health_label.text = get_boss_health_string(resource)
	boss_health_percentage_label.text = get_boss_health_percentage_string(resource)
	
func on_encounter_ended() -> void:
	visible = false
