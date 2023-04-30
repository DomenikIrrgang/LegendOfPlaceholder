class_name Castbar
extends Control

@onready
var progress_bar: TextureProgressBar = $CenterContainer/Background/ProgressBar

@onready
var spell_name_label: Label = $CenterContainer/Background/CenterContainer/SpellName

func _ready() -> void:
	visible = false

func initialize(unit: Unit) -> void:
	unit.cast_started.connect(on_cast_started)
	unit.cast_canceled.connect(on_cast_canceled)
	unit.cast_interupted.connect(on_cast_interupted)
	unit.cast_finished.connect(on_cast_finished)

func on_cast_started(source: Unit, target: Unit, ability: Ability, duration: float) -> void:
	var tween = create_tween()
	visible = true
	progress_bar.value = 0
	progress_bar.max_value = 1000
	tween.tween_property(progress_bar, "value", 1000, duration)
	spell_name_label.text = ability.get_alias()
	
func on_cast_canceled(source: Unit, target: Unit, ability: Ability) -> void:
	visible = false
	
func on_cast_interupted(source: Unit, target: Unit, ability: Ability) -> void:
	visible = false
	
func on_cast_finished(source: Unit, target: Unit, ability: Ability) -> void:
	visible = false
