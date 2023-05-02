@tool
class_name SelectableLabel
extends Control

@onready
var label: Label = $Label

@onready
var background_color: ColorRect = $BackgroundColor

func _ready() -> void:
	background_color.visible = false
	focus_entered.connect(on_focus_entered)
	focus_exited.connect(on_focus_exited)
	
func on_focus_entered() -> void:
	background_color.visible = true
	
func on_focus_exited() -> void:
	background_color.visible = false
	
func get_text() -> String:
	return label.text
	
func set_text(value: String) -> void:
	label.text = value
