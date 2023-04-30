extends Node

signal receive(message: String)

func send(message: String) -> void:
	receive.emit(message)
