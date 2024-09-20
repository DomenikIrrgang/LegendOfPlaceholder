class_name Interactable
extends Area2D

var outline_shader = preload("res://Shaders/Outline.gdshader")

func interact() -> void:
	InteractionManager.prompt_interactions(owner.unit_data, get_interactions())
	
func get_interactions() -> Array[Interaction]:
	return owner.unit_data.interactions
	
func get_unit_data() -> UnitData:
	return owner.unit_data
	
func is_interactable() -> bool:
	return InteractionManager.get_interactions_to_prompt(get_interactions()).size() > 0
	
func set_outline(enabled: bool) -> void:
	if enabled:
		owner.model.material = ShaderMaterial.new()
		owner.model.material.shader = outline_shader
		owner.model.material.set_shader_parameter("color", Vector4(1, 1, 1, 0.4))
		for child in owner.model.get_children():
			child.material = ShaderMaterial.new()
			child.material.shader = outline_shader
			child.material.set_shader_parameter("color", Vector4(1, 1, 1, 0.7))
	else:
		if owner:
			owner.model.material = null
			for child in owner.model.get_children():
				child.material = null
