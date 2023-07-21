extends RayWeaponConfig


func _ready():
	super()
	weapon = Global.Weapons.RIFLE
	weapon_name = Global.Weapons.keys()[weapon].to_lower()
	dmg = Global.dmg[weapon]
	is_auto = true
	raycasts = [$Barrel/RayCast2D as RayCast2D]
