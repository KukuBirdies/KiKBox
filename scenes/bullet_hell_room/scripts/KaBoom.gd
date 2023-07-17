extends CharacterBody2D


class_name KaBoom

@export var projectile: PackedScene
@onready var barrel_one: Marker2D = $Barrel
@onready var anim = $AnimatedSprite2D
@onready var timer = $shoot_timer

var target1: Player
var alive = 1


func _ready() -> void:
	anim.play("idle")


func facing() -> void: 
	if target1 == null: 
		target1 = get_parent().get_node("Player")
	
	else:
		look_at(target1.global_position)


func _physics_process(_delta: float) -> void:
	if alive:
		facing()


func shoot() -> void: 
	var bullet_one : Rocket = projectile.instantiate()
	bullet_one.spawned_from = self
	owner.add_child(bullet_one)
	bullet_one.global_transform = barrel_one.global_transform


func _on_shoot_timer_timeout() -> void:
	shoot()
	anim.play("fire")


func _on_health_manager_died() -> void:
	anim.play("died")
	alive = 0
	timer.stop()
	
