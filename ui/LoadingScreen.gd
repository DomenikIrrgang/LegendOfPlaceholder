extends CanvasLayer

@onready
var background: Sprite2D = $Background

func take_screenshot() -> void:
	var frame_data = get_viewport().get_texture().get_image()
	var screenshot = ImageTexture.create_from_image(frame_data)
	background.texture = screenshot
	background.material.set_shader_parameter("dissolve_state", 0.0)
	var tween = create_tween()
	tween.tween_property(background.material, "shader_parameter/dissolve_state", 1.1, 1.5)
	tween.play()
