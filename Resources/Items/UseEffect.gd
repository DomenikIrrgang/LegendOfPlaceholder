class_name UseEffect
extends Resource

@export
var cooldown_group: CooldownGroup

func use(source: Unit) -> bool:
	if !is_on_cooldown():
		var success = on_use(source)
		if success and has_cooldown():
			start_cooldown()
		return success 
	return false
	
func is_on_cooldown() -> bool:
	if has_cooldown():
		return CooldownSystem.is_on_cooldown(cooldown_group.alias)
	return false
	
func start_cooldown() -> void:
	CooldownSystem.start_cooldown(cooldown_group.alias, cooldown_group.cooldown)
	
func reset_cooldown() -> void:
	CooldownSystem.reset_cooldown(cooldown_group.alias)

func has_cooldown() -> bool:
	return cooldown_group != null

func on_use(_source: Unit) -> bool:
	return true
	
func get_remaining_cooldown() -> float:
	if is_on_cooldown():
		return CooldownSystem.get_cooldown(cooldown_group.alias)
	return 0.0
	
func get_cooldown_progress() -> float:
	return get_remaining_cooldown() * 100.0 / cooldown_group.cooldown
