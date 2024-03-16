class_name BasicWand
extends Weapon

var FireballProjectile = preload("res://Combat/abilities/FireballAnimation.tscn")
var Fireball = preload("res://Combat/abilities/Fireball.tscn")

func _ready() -> void:
	super()

func attack(_player: Player) -> AnimationPlayer:
	var fireball_projectile_instance = FireballProjectile.instantiate()
	var fireball = Fireball.instantiate()
	Globals.get_world().add_child(fireball_projectile_instance)
	fireball_projectile_instance.init_projectile(Globals.get_player(), fireball, Globals.get_player().get_facing_direction(), 100.0)
	fireball_projectile_instance.global_position = Globals.get_player().model.global_position
	animation.play("Attack")
	return animation
