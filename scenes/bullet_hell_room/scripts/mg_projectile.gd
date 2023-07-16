extends Area2D

class_name MGProjectile

var speed : float = 10.0
var damage : float = 00 
var spawned_from : Node
var time_to_live: float = 10

func _ready() -> void: 
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


func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox and area.entity is Player:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is TileMap:
		queue_free()
