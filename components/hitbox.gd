class_name Hitbox
extends Area2D

# Calls .hurt() on any Hurtbox it touches when active (recommended to be activated through an AnimationPlayer)

# Origin of damage is position of this node, draw the CollisionShape2D relative to that
@export var dmg: int	# Raw damage dealt to Hurtbox (Hurtbox might have it's own armor to lower effective dmg)

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(area):
	print(area)
	if area is Hurtbox:
		var hurtbox: Hurtbox = area
		# Recall: origin of damage is position of this node, draw the CollisionShape2D relative to that
		var dir: Vector2 = global_position.direction_to(hurtbox.global_position)
		hurtbox.hurt(dmg, dir)
