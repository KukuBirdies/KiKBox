extends Area2D

class_name MGProjectile

var speed : float = 10.0
var damage : float = 00 
var spawned_from : Node
var time_to_live: float = 10

func _ready() -> void: 
	body_entered.connect(on_body_entered)
	handle_time_to_live()


func handle_time_to_live() -> void:
	var ttl_timer : Timer = Timer.new()
	add_child(ttl_timer)
	ttl_timer.wait_time = time_to_live
	ttl_timer.one_shot = true
	ttl_timer.timeout.connect(func(): queue_free())
	ttl_timer.start()


func _physics_process(_delta: float) -> void:
	position += transform.x * speed

func on_body_entered(body : Node2D) -> void: 
	if body == spawned_from: 
		return 
	
	if body is Player:
		# var body_shot : Player = body as Player
		# body_shot.apply_damage(damage) 
		queue_free()
