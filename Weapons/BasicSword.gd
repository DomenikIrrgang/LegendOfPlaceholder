class_name BasicSword
extends Weapon

func _ready() -> void:
	super()
	$Animation.connect("animation_started", _on_attack_start)
	$Animation.connect("animation_finished", _on_attack_finished)


func attack(player: Player) -> AnimationPlayer:
	match (player.direction):
		Player.Direction.LEFT:
			animation.play("Attack_Left")
			player.set_animation("Attack_Left")
			position.x = -10
			position.y = 3
		Player.Direction.DOWN:
			animation.play("Attack_Down")
			player.set_animation("Attack_Down")
			position.x = 0
			position.y = 10
		Player.Direction.RIGHT:
			animation.play("Attack_Right")
			player.set_animation("Attack_Right")
			position.x = 10
			position.y = 0
		Player.Direction.UP:
			animation.play("Attack_Up")
			player.set_animation("Attack_Up")
			position.x = 0
			position.y = -10
	return animation
	
func _on_attack_start(animation_name: String) -> void:
	$HitBox2D/HitBox.disabled = false
	
func _on_attack_finished(animation_name: String) -> void:
	$HitBox2D/HitBox.disabled = true
