extends Area2D

class_name Explosion

var damage: float = 0
var time_to_live: float = 0.1

func _ready() -> void: 
	handle_time_to_live()


func handle_time_to_live() -> void:
	var ttl_timer : Timer = Timer.new()
	add_child(ttl_timer)
	ttl_timer.wait_time = time_to_live
	ttl_timer.one_shot = true
	ttl_timer.timeout.connect(func(): queue_free())
	ttl_timer.start()


func _on_area_entered(area: Area2D) -> void:
	pass # for damaging node


