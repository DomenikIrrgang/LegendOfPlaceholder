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

@onready
var inventory: InventoryWindow = $Inventory

@onready
var bank: InventoryWindow = $Bank

@onready
var buffs: StatusEffectBar = $Buffs

@onready
var debuffs: StatusEffectBar = $Debuffs

func _ready() -> void:
	main_hud.initialize(player)
	player_castbar.initialize(player)
	system_message.initialize(player)
	inventory.initialize(Globals.get_inventory())
	bank.initialize(Globals.get_bank())
	buffs.initialize(player)
	debuffs.initialize(player)
