extends CanvasLayer

@onready
var background: Sprite2D = $Background

var tween: Tween

func _ready() -> void:
	SceneSwitcher.zone_loading.connect(on_zone_loading)
	pass
	
func on_zone_loading() -> void:
	visible = true
	take_screenshot()
	
func on_zone_loaded() -> void:
	visible = false

func take_screenshot() -> void:
	var frame_data = get_viewport().get_texture().get_image()
	var screenshot = ImageTexture.create_from_image(frame_data)
	background.texture = screenshot
	background.material.set_shader_parameter("dissolve_state", 0.0)
	if tween != null:
		tween.kill()
	tween = create_tween()
	tween.tween_property(background.material, "shader_parameter/dissolve_state", 1.1, 0.75)
	tween.finished.connect(on_zone_loaded)
	tween.play()
