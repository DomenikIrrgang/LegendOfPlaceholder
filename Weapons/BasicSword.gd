class_name BasicSword
extends Weapon

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
