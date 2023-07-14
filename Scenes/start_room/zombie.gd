extends CharacterBody2D
#variables for movement
@export var speed = 60
var player_chase = false
var player = null
#variables for combat
var health = 100


func _physics_process(delta):
	if player_chase:
		look_at(player.global_position)
		var direction: Vector2 = player.position - position
		direction = direction.normalized()
		velocity = direction * speed

		$AnimatedSprite2D.play("walking")
		
	else:
		$AnimatedSprite2D.play("idle")
	move_and_slide()

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	
func enemy():
	pass



func _on_zombie_hitbox_body_entered(body):
	pass # Replace with function body.


func _on_zombie_hitbox_body_exited(body):
	pass # Replace with function body.
