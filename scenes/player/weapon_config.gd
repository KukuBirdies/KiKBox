extends Node2D

signal ray_fired(dmg: int, ray_hit_info: RayHitInfo)
signal knockbacked(speed: float, rel_dir: Vector2)

@export var Pistol: PackedScene
@export var Rifle: PackedScene
@export var Shotgun: PackedScene

var weapon_scene: Node2D
var weapon: Global.Weapons
var weapon_name: String
var dmg: int
var is_auto: bool
var weapon_shape: CollisionShape2D
var player_gun_offset: float
var raycasts: Array[RayCast2D]

@onready var config_packed_scenes = {
	Global.Weapons.PISTOL: Pistol,
	Global.Weapons.RIFLE: Rifle,
	Global.Weapons.SHOTGUN: Shotgun
}

func config_for(weapon: Global.Weapons):
	if weapon_scene:
		weapon_scene.queue_free()
	self.weapon_scene = config_packed_scenes[weapon].instantiate()
	add_child(self.weapon_scene)
	self.weapon = weapon_scene.weapon
	self.weapon_name = weapon_scene.weapon_name
	self.dmg = weapon_scene.dmg
	self.is_auto = weapon_scene.is_auto
	self.weapon_shape = weapon_scene.weapon_shape
	self.player_gun_offset = weapon_scene.player_gun_offset
	self.raycasts = weapon_scene.raycasts
	assert(self.player_gun_offset != 0)
	# Note that the self. here are optional, mainly for differentiating
	# self.weapon from the weapon argument
	
	weapon_scene.connect("knockbacked", _on_weapon_knockbacked)

func fire():
	# Called from AnimationPlayer
	var ray_hit_infos = weapon_scene.fire()
	for ray_hit_info in ray_hit_infos:
		emit_signal("ray_fired", dmg, ray_hit_info)

func _on_weapon_knockbacked(speed: float):
	emit_signal("knockbacked", speed, to_global(Vector2.LEFT)-global_position)
