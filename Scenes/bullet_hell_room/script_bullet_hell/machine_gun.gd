extends CharacterBody2D


class_name MachineGun

@export var projectile: PackedScene
@onready var barrel_one: Marker2D = $MG_bullet_1
@onready var barrel_two: Marker2D = $MG_bullet_2
var target1: Player

func _ready() -> void:
	var anim = $AnimatedSprite2D
	anim.play("default")


func facing() -> void: 
	if target1 == null: 
		target1 = get_parent().get_node("Player")
	
	else: 
		look_at(target1.global_position)


func _physics_process(_delta: float) -> void:
	facing()


func shoot() -> void: 
	var bullet_one : MGProjectile = projectile.instantiate()
	var bullet_two : MGProjectile = projectile.instantiate()
	bullet_one.spawned_from = self
	bullet_two.spawned_from = self 
	owner.add_child(bullet_one)
	owner.add_child(bullet_two)
	bullet_one.global_transform = barrel_one.global_transform
	bullet_two.global_transform = barrel_two.global_transform


func _on_shoot_timer_timeout() -> void:
	shoot()
