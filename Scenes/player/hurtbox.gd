class_name Hurtbox
extends Area2D

signal received_damage

@export var health_manager: HealthManager

func hurt(dmg, dir: Vector2):
	emit_signal("received_damage", dmg, dir)
