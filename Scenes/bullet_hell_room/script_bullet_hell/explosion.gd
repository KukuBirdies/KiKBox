extends Area2D

class_name Explosion

var damage: float = 0


func _ready() ->void: 
	body_entered.connect(on_body_entered) 

# effect of projectile
func on_body_entered(body: Node2D) ->void: 
	if body is Player: # Enemy is the class_name
		var player : Player = body as Player # Converting the body (argument) which is an Enemy to an actual enemy class so we can use the Enemy Properties, this give us type safety
		# enemy.apply_damage(damage)
	queue_free() # Remove that memory from the current frame

