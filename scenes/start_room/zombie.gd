extends CharacterBody2D
#variables for movement
@export var speed = 60

#Code from sample_level
const pushback: float = 100
const pushback_fric: float = 0.08
#Vector2.ZERO -> .ZERO implies that the vector has no length? no mangnitude??
#Technically can just wrtie Vector2 coordinates at the back, but people on godot say put .zero so that math will be more consistant?? but why?
var pushback_vel := Vector2.ZERO 

var player_hurt = false
var player_attack = false
var player_chase = false
var player = null

@onready var animation = $AnimationPlayer
#variables for combat
# var health = 100


func _physics_process(delta):
	if player_chase:
		look_at(player.global_position)
		var direction: Vector2 = player.position - position
		direction = direction.normalized()
		velocity = direction * speed

		animation.play("walk")
	elif player_hurt:
		animation.play("attack")
		pushback_vel = lerp(pushback_vel, Vector2.ZERO, pushback_fric)
		velocity = pushback_vel
		move_and_slide()
	elif player_attack:
		pass
	else:
		$AnimationPlayer.play("idle")
	move_and_slide()

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	

func _on_zombie_hitbox_body_entered(body):
	pass

func _on_hurtbox_received_damage(eff_dmg, dir):
	player_hurt = true
	


func _on_health_manager_died():
	queue_free()
