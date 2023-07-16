class_name Hurtbox
extends Area2D

signal received_damage(eff_dmg: int, dir: Vector2)

@export var entity: Node2D
@export var health_manager: HealthManager
@export var DfltBulletHitFX: PackedScene = preload("res://scenes/bullets/dflt_enemy_bullet_hit_fx.tscn") # Test
@export_range(0, 1) var armor: float = 0


func _ready() -> void:
	if entity == null: 
		entity = get_parent()


func hurt(dmg: int, dir: Vector2):
	# dir: the global normalized direction of the bullet / projectile
	var eff_dmg: int = ceili(dmg * (1-armor))
	assert(eff_dmg >= 0)
	if health_manager:
		health_manager.take_dmg(eff_dmg)
	emit_signal("received_damage", eff_dmg, dir)

func play_bullet_hit_fx(rel_pos: Vector2, glob_normal: Vector2, BulletHitFX: PackedScene = null):
	if BulletHitFX == null:	# Use default BulletHitFX unless otherwise stated
		BulletHitFX = DfltBulletHitFX
	var bullet_impact_fx := BulletHitFX.instantiate()
	bullet_impact_fx.position = rel_pos
	bullet_impact_fx.global_rotation = glob_normal.angle()
	add_child(bullet_impact_fx)		# Frees in auto-played animation
