extends Node

var cooldowns = {}

func _process(delta):
	for cooldown in cooldowns.keys():
		reduce_cooldown(cooldown, delta)
			
func start_cooldown(cooldown: String, duration: float) -> void:
	cooldowns[cooldown] = duration
	
func get_cooldown(cooldown: String) -> float:
	return cooldowns[cooldown]
	
func is_on_cooldown(cooldown: String) -> bool:
	return cooldowns.has(cooldown) and cooldowns[cooldown] != null

func reset_cooldown(cooldown: String) -> void:
	cooldowns[cooldown] = null
	
func reduce_cooldown(cooldown: String, duration: float) -> void:
	if is_on_cooldown(cooldown):
		cooldowns[cooldown] -= duration
		if cooldowns[cooldown] <= 0.0:
			cooldowns[cooldown] = null
