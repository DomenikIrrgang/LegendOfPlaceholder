class_name GameUI
extends Control

@export
var player: Player

@onready
var main_hud: MainHUD = $MainHUD

@onready
var system_message: SystemMessage = $SystemMessage

func _ready() -> void:
	main_hud.initialize(player)

	
	
