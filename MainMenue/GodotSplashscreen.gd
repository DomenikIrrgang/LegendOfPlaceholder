extends Node2D

@onready
var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.connect("animation_finished", animation_finished)
	animation_player.play("LogoAnimation")
	
func animation_finished(animation_name: String) -> void:
	get_tree().change_scene_to_file("res://MainMenue/MainMenue.tscn")
