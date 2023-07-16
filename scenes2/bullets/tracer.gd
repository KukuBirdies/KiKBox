extends Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	texture.set_current_frame(randi_range(0,3))	# texture is an AnimatedTexture hence has frames
	await get_tree().create_timer(0.015).timeout
	queue_free()

