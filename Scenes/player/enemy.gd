extends CharacterBody2D


func _on_hurtbox_received_damage(dmg, dir: Vector2):
	print("{s} says: OUCH".format({"s": self}))
