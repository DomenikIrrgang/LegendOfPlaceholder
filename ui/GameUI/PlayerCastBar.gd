class_name Castbar
extends Control

@onready
var progress_bar: TextureProgressBar = $CenterContainer/Background/ProgressBar

@onready
var spell_name_label: Label = $CenterContainer/Background/CenterContainer/SpellName

var ability: Ability

func _ready() -> void:
	visible = false

func initialize(unit: Unit) -> void:
	unit.cast_started.connect(on_cast_started)
	unit.cast_canceled.connect(on_cast_canceled)
	unit.cast_interupted.connect(on_cast_interupted)
	unit.cast_finished.connect(on_cast_finished)
	unit.current_cast_update.connect(on_current_cast_update)

func on_cast_started(_source: Unit, _target: Unit, _ability: Ability, duration: float) -> void:
	ability = _ability
	visible = true
	spell_name_label.text = ability.get_alias()
	progress_bar.max_value = duration
	print(progress_bar.texture_over, progress_bar.texture_progress)
	
func on_current_cast_update(_source: Unit, _target: Unit, _ability: Ability, current_cast: float, _cast_time: float) -> void:
	progress_bar.value = current_cast
	
func on_cast_canceled(_source: Unit, _target: Unit, _ability: Ability) -> void:
	visible = false
	ability = null
	
func on_cast_interupted(_source: Unit, _target: Unit, _ability: Ability) -> void:
	visible = false
	ability = null
	
func on_cast_finished(_source: Unit, _target: Unit, _ability: Ability) -> void:
	visible = false
	ability = null
