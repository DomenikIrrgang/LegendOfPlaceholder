class_name Model
extends Node2D

@onready
var model: Sprite2D = $Model

@onready
var model_animation: AnimationPlayer = $ModelAnimation

@onready
var collision: CollisionShape2D = $Collision

@onready
var interaction: CollisionShape2D = $Interaction
	
func get_idle_down_animation() -> String:
	return "PlayerAnimations/Idle_Down"
	
func get_idle_up_animation() -> String:
	return "PlayerAnimations/Idle_Down"
	
func get_idle_left_animation() -> String:
	return "PlayerAnimations/Idle_Down"
	
func get_idle_right_animation() -> String:
	return "PlayerAnimations/Idle_Down"
	
func get_down_animation() -> String:
	return "PlayerAnimations/Idle_Down"
	
func get_up_animation() -> String:
	return "PlayerAnimations/Idle_Down"
	
func get_left_animation() -> String:
	return "PlayerAnimations/Idle_Down"
	
func get_right_animation() -> String:
	return "PlayerAnimations/Idle_Down"


