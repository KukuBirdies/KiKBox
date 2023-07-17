extends Area2D

class_name Explosion

var damage: float = 0


func _on_area_entered(area: Area2D) -> void:
	queue_free()
