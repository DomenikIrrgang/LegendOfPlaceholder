class_name GameUI
extends Control

@export
var player: Player

@onready
var dashmeter: DashMeter = $DashMeter

func _ready() -> void:
	dashmeter.initialize(player)
	
