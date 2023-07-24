extends RayWeaponConfig

func _ready():
	super()
	weapon = Global.Weapons.PISTOL
	weapon_name = Global.Weapons.keys()[weapon].to_lower()
	dmg = Global.dmg[weapon]
	is_auto = false
	raycasts = [$Barrel/RayCast2D as RayCast2D]
	tremor = 0.2
