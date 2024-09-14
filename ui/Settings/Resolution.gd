extends OptionButton

var resolutions: Dictionary = {
	"3840x2160": Vector2(3840, 2160),
	"2560x1440": Vector2(2560, 1440),
	"1920x1080": Vector2(1920, 1080),
	"1280x720": Vector2(1280, 720),
	"853x480": Vector2(853, 480)
}

func _ready():
	for resolution in resolutions:
		add_item(resolution)
	item_selected.connect(on_mode_selected)
		
func on_mode_selected(index: int) -> void:
	var key = get_item_text(index)
	var size = resolutions[key]
	get_window().content_scale_factor = 1920 / size.x
