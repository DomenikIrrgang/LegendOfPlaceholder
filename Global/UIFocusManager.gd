extends Node

var previous_focus: Control

func _ready() -> void:
	Globals.get_viewport().gui_focus_changed.connect(on_focus_changed)
	
func on_focus_changed(control: Control) -> void:
	if control is PanelContainer:
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Color.TRANSPARENT
		style_box.set_border_width_all(3)
		style_box.border_color = Color.WHITE
		control.add_theme_stylebox_override("panel", style_box)
	if previous_focus != null and previous_focus is PanelContainer:
		previous_focus.add_theme_stylebox_override("panel", StyleBoxEmpty.new())
	previous_focus = control

class FocusCache:
	var focus_mode: Control.FocusMode
	var mouse_filter: Control.MouseFilter
	var mouse_scroll: bool
	
	func _init(_focus_mode : Control.FocusMode, _mouse_filter : Control.MouseFilter, _mouse_scroll : bool):
		self.focus_mode = _focus_mode
		self.mouse_filter = _mouse_filter
		self.mouse_scroll = _mouse_scroll
		
func contain_focus_in_control(control: Control) -> Dictionary:
	var original_state_cache: Dictionary = disable_focus_for_control(Globals.get_user_interface(), {})
	reenable_focus_for_control(control, original_state_cache)
	return original_state_cache
	
func restore_focus_in_ui(original_state_cache: Dictionary) -> void:
	reenable_focus_for_control(Globals.get_user_interface(), original_state_cache)
	
func disable_focus_for_control(control: Control, cache: Dictionary) -> Dictionary:
	var focus_mode = control.focus_mode
	var mouse_filter = control.mouse_filter
	var mouse_scroll = control.mouse_force_pass_scroll_events
	if focus_mode != Control.FocusMode.FOCUS_NONE or mouse_filter != Control.MouseFilter.MOUSE_FILTER_IGNORE or mouse_scroll == false:
		var cache_item = FocusCache.new(focus_mode, mouse_filter, mouse_scroll)
		cache[control] = cache_item
		control.focus_mode = Control.FocusMode.FOCUS_NONE
		control.mouse_filter = Control.MouseFilter.MOUSE_FILTER_IGNORE
		control.mouse_force_pass_scroll_events == false
	for child in control.get_children():
		if child is Control:
			disable_focus_for_control(child, cache)
	return cache
	
func reenable_focus_for_control(control: Control, cache: Dictionary) -> void:
	if cache.has(control):
		var previous := cache[control] as FocusCache
		control.focus_mode = previous.focus_mode
		control.mouse_filter = previous.mouse_filter
		if "mouse_scroll" in control:
			control.mouse_scroll = previous.mouse_scroll
		cache.erase(control)
	for child in control.get_children():
		if child is Control:
			reenable_focus_for_control(child, cache)
