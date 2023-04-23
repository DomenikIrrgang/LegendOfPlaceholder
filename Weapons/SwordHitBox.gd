extends HitBox2D

func on_hit(hurt_box: HurtBox2D) -> void:
	print("hit something")
	if (!hurt_box):
		return
	var unit: Unit = hurt_box.owner
	unit.change_health(-250)
