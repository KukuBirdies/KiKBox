class_name RayWeaponConfig
extends Node2D

# Base Class for all hit-scan (raycast) weapons
# Firing means returning a list of RayHitInfo (list since
# weapons can have multiple bullets/rays - e.g. Shotgun)

signal ray_fired(weapon: String, ray_hit_info: RayHitInfo)

var weapon: Global.Weapons
var weapon_name: String
var dmg: int
var is_auto: bool
var player_gun_offset: float
var raycasts: Array[RayCast2D]	# Needs to be accessed in Player to force update after movement

@onready var weapon_shape := $WeaponCollisionShape	# To be copied by player
@onready var aim_from = $AimFrom

func _ready():
	assert(aim_from.position.x == 0)
	player_gun_offset = aim_from.position.y
	var test: Array[RayCast2D]


func fire() -> Array[RayHitInfo]:
	# Indirectly called by AnimationPlayer through Player
	print("called")
	var ray_hit_infos: Array[RayHitInfo] = []
	for raycast in raycasts:
		ray_hit_infos.append(RayHitInfo.new(raycast))
	return ray_hit_infos
