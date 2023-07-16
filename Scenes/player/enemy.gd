extends CharacterBody2D

const KNOCKBACK: float = 100
const KNOCKBACK_FRIC: float = 0.08

var knockback_vel := Vector2.ZERO

func _physics_process(_delta):
	knockback_vel = lerp(knockback_vel, Vector2.ZERO, KNOCKBACK_FRIC)
	velocity = knockback_vel
	move_and_slide()

func _on_hurtbox_received_damage(_dmg, dir):
	# HurtPlayer is a separate AnimationPlayer to allow for the "flash" animation to play
	# simultaneously with the player's current animation in the main AnimationPlayer (optional)
	$HurtPlayer.play("flash")
	knockback_vel = dir * KNOCKBACK


func _on_health_manager_died():
	$AnimationPlayer.play("death")
