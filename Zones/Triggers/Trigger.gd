class_name Trigger
extends Area2D

@export
var conditions: Array[Condition] = []

var player_inside: bool = false

func _ready() -> void:
	area_entered.connect(on_player_entered)
	area_exited.connect(on_player_exited)
	
func on_player_entered(player_collision: Area2D) -> void:
	if not player_inside and player_collision.owner is Player:
		player_inside = true
		if are_conditions_fulfilled():
			trigger()
	
func on_player_exited(player_collision: Area2D) -> void:
	player_inside = false
	
func are_conditions_fulfilled() -> bool:
	for condition in conditions:
		if not condition.is_fulfilled():
			return false
	return true
	
func trigger() -> void:
	pass
