class_name InteractionOption
extends PanelContainer

@onready
var icon: TextureRect = $Margin/Spacing/Icon

@onready
var label: Label = $Margin/Spacing/Label

@onready
var background: NinePatchRect = $NinePatchRect

func init(interaction: Interaction) -> void:
	icon.texture = interaction.get_icon()
	label.text = interaction.get_alias()

func select() -> void:
	background.material.set_shader_parameter("enabled", 0.0)
	
func unselect() -> void:
	background.material.set_shader_parameter("enabled", 1.0)
