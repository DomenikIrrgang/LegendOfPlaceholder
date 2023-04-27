class_name GameUI
extends Control

@export
var player: Player

@onready
var dashmeter: DashMeter = $DashMeter

@onready
var main_hud: MainHUD = $MainHUD

@onready
var system_message: SystemMessage = $SystemMessage

func _ready() -> void:
	dashmeter.initialize(player)
	main_hud.initialize(player)
	system_message.initialize(player)
	
	
