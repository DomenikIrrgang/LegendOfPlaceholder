class_name GameUI
extends Control

@export
var player: Player

@onready
var dashmeter: DashMeter = $DashMeter

@onready
var unit_frame_player: UnitFramePlayer = $UnitFramePlayer

@onready
var system_message: SystemMessage = $SystemMessage

@onready
var experience_bar: ExperienceBar = $ExperienceBar

func _ready() -> void:
	dashmeter.initialize(player)
	unit_frame_player.initialize(player)
	system_message.initialize(player)
	experience_bar.initialize(player)
	
	
