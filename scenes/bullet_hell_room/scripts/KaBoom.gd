extends CharacterBody2D


class_name KaBoom

@export var projectile: PackedScene
@onready var barrel_one: Marker2D = $Barrel

var target1: Player
@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	anim.play("idle")


func facing() -> void: 
	if target1 == null: 
		target1 = get_parent().get_node("Player")
	
	else:
		look_at(target1.global_position)


func _physics_process(_delta: float) -> void:
	facing()


func shoot() -> void: 
	var bullet_one : Rocket = projectile.instantiate()
	bullet_one.spawned_from = self
	owner.add_child(bullet_one)
	bullet_one.global_transform = barrel_one.global_transform


func _on_shoot_timer_timeout() -> void:
	shoot()
	anim.play("fire")
