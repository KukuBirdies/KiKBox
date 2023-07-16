extends CharacterBody2D

class_name Rotator

@export var projectile : PackedScene
@onready var shoot_timer : Timer = $ShootTimer
@onready var rotator : Node2D = $Rotate

const rotate_speed: float = 80.0  # 0 / 50 / 80
const shooter_time_wait_time: float = 0.2 # 0.15 / 0.2 /0.2
const spawn_pointer_count: int = 3 # 8 / 6 /3
const radius : float = 70

func _ready(): 
	var step = 2 * PI / spawn_pointer_count
	
	for i in range(spawn_pointer_count): 
		var spawn_point: Node2D = Node2D.new()
		var pos : Vector2 = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator.add_child(spawn_point)
	
	shoot_timer.wait_time = shooter_time_wait_time
	shoot_timer.start()

func _process(delta: float) -> void:
	var new_rotation = rotator.rotation_degrees + rotate_speed * delta
	rotator.rotation_degrees = fmod(new_rotation,360) 


func _on_shoot_timer_timeout() -> void:
	for s in rotator.get_children(): 
		var bullet : RotateProjectile = projectile.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position 
		bullet.rotation = s.global_rotation 
