extends RayWeaponConfig

var rng = RandomNumberGenerator.new()

func _ready():
	super()
	weapon = Global.Weapons.SHOTGUN
	weapon_name = Global.Weapons.keys()[weapon].to_lower()
	dmg = Global.dmg[weapon]
	is_auto = false
	raycasts = []
	for ray in $Barrel/RayCasts.get_children():
		assert(ray is RayCast2D)
		raycasts.append(ray)

func fire() -> Array[RayHitInfo]:
	# Indirectly called by AnimationPlayer through Player
	for raycast in raycasts:
		# Set the next random spread, note that if we want to set the random
		# at time-of-fire then we will need to force_raycast_update after setting
		# the rotation which is unnecessary hence this implementation
		raycast.rotation = rng.randfn(0, 0.049)	# 0.999 chance of having max 9º spread off-centre
	$Barrel/GPUParticles2D.emitting = true
	return super()
