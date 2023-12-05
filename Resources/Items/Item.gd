class_name Item
extends Resource

@export
var alias: String

@export
var useable: bool

@export
var use_effect: UseEffect

@export_multiline
var use_description: String

@export
var limited: bool = false

@export
var limit: int = 1

@export
var stackable: bool = false

@export
var stack_amount: int = 5

@export_multiline
var description: String

@export
var icon: Texture

