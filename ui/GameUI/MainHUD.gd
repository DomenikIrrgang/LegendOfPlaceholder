class_name MainHUD
extends Control

@onready
var health_bar: HealthBar = $CenterContainer/Overlay/HealthBar

@onready
var experience_bar: ExperienceBar = $CenterContainer/Overlay/ExperienceBar

@onready
var resource_bar: ResourceBar = $CenterContainer/Overlay/ResourceBar

@onready
var dash_bar: DashBar = $CenterContainer/Overlay/DashBar

func initialize(player: Player) -> void:
	health_bar.initialize(player)
	resource_bar.initialize(player)
	experience_bar.initialize(player)
	dash_bar.initialize(player)
