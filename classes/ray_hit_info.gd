class_name RayHitInfo

# GDScript has no Static Variables (AKA Class Variables) hence all these are instance variables
var collider		# Object: Object that was hit (null if none)
var global_rotation	# float: Global rotation of ray in radians
var from			# Vector2: Global start of the ray
var to				# Vector2: Global end of the ray (null if nothing hit)
var dir				# Vector2: Global normalized direction of the ray
var normal			# Vector2: Normal of the surface hit
var dist:			# float: Only calculated on first query (sqrt is expensive)
	get: return from.distance_to(to) if (dist == null and collider != null) else dist
# These are all implicitely initialised as null
# (hence the lack of type-hinting as statically typed Vector2 cannot be null)

func _init(raycast2d: RayCast2D):
	collider = raycast2d.get_collider()
	from = raycast2d.global_position
	global_rotation = raycast2d.global_rotation
	dir = (raycast2d.target_position - raycast2d.position).rotated(global_rotation).normalized()
	if collider:
		to = raycast2d.get_collision_point()
		normal = raycast2d.get_collision_normal()

func print_info():
	print("Collider: ", collider)
	print("From: ", from)
	print("To: ", to)
	print("Direction: ", dir)
	print("Normal: ", normal)
	print("Distance: ", dist)
