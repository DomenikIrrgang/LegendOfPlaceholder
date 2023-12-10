extends Node

signal on_event(event: String, data: Dictionary)

func emit_event(event: String, data: Dictionary) -> void:
	on_event.emit(event, data)
