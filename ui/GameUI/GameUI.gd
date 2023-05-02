class_name GameUI
extends Control

@export
var player: Player

@onready
var main_hud: MainHUD = $MainHUD

@onready
var system_message: SystemMessage = $SystemMessage

@onready
var player_castbar: Castbar = $PlayerCastBar

func _ready() -> void:
	main_hud.initialize(player)
	player_castbar.initialize(player)
	
