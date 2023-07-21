class_name Player
extends CharacterBody2D

# Player interacts with the room (bullet/projectiles/etc) strictly through the
# PlayerInteractableRoom it is in - All rooms that want to interact with the
# player will inherit from player_interactable_room.tscn
# 
# Signal connection are the job of 

signal ray_fired(dmg: int, ray_hit_info: RayHitInfo)

const MAXSPEED = 300.0
const ACCELERATION = 0.4	# 1 means instant acceleration
const FRICTION = 0.2		# 1 means instant deceleration

var player_gun_offset: int
var weapon_collision_shape: CollisionShape2D

@onready var weapon_config = $WeaponConfig
@onready var anim_state_machine = $AnimationPlayer/AnimationTree.get("parameters/playback")
@onready var crosshair: Sprite2D = $Crosshair

func _ready():	
	equip_weapon(Global.Weapons.PISTOL)
	_init_hitboxes_dmg()

func _physics_process(_delta):
	aim()
	# Movement
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	direction = direction.normalized()

	if direction:
		velocity = velocity.lerp(direction * MAXSPEED, ACCELERATION)	# Exponentially accelerate
		anim_state_machine.travel(weapon_ani_name(weapon_config.weapon_name, "move"))
	else:
		velocity = velocity.lerp(Vector2.ZERO, FRICTION)	# Exponentially decelerate
		anim_state_machine.travel(weapon_ani_name(weapon_config.weapon_name, "idle"))
	
	if Input.is_action_just_pressed("melee"):
		melee()
	elif Input.is_action_just_pressed("attack"):
		anim_state_machine.travel(weapon_ani_name(weapon_config.weapon_name, "shoot"))
	elif weapon_config.is_auto and Input.is_action_pressed("attack"):
		# Fire rate and action is handled in AnimationPlayer :D
		anim_state_machine.travel(weapon_ani_name(weapon_config.weapon_name, "shoot"))
	
	#print("Currently Playing: ", anim_state_machine.get_current_node())
	
	for raycast in weapon_config.raycasts:
		raycast.force_raycast_update()	# Effects are amplified when aiming while moving
	move_and_slide()	# Intrinsically handles delta

func aim():
	# Rotates player such that gun aims at crosshair
	var offset_angle = atan2(weapon_config.player_gun_offset, global_position.distance_to(crosshair.global_position))
#	print(aim_from.get_angle_to(crosshair.global_position))
	rotate(get_angle_to(crosshair.global_position) - offset_angle)	# get_angle_to takes in global coords, and has a sense of "front" for a Node2D
		#rotate(aim_from.get_angle_to(crosshair.global_position))	# WRONG! Quite funny it still converges and works

func melee():
	anim_state_machine.travel(weapon_ani_name(weapon_config.weapon_name, "melee"))
	crosshair.set_crosshair(Global.Weapons.RIFLE)
	print("Melee attack with %s" % weapon_config.weapon_name)
	

func weapon_ani_name(weapon_name: String, action: String):
	# Get animation name used in AnimationPlayer
	return "%s_%s" % [weapon_name, action]

func equip_weapon(weapon: Global.Weapons):
	weapon_config.config_for(weapon)
	if weapon_collision_shape:
		weapon_collision_shape.queue_free()
	weapon_collision_shape = weapon_config.weapon_shape.duplicate()
	weapon_collision_shape.name = "WeaponCollisionShape"
	call_deferred("add_child", weapon_collision_shape)	# Adds child only when not calculating Physics
	print(weapon_config.weapon_name)

func _init_hitboxes_dmg():
	$MeleeHitbox.dmg = Global.dmg[Global.Weapons.GUN_MELEE]


func _on_weapon_config_ray_fired(dmg, ray_hit_info):
	# Pass-through to BaseLevel
	emit_signal("ray_fired", dmg, ray_hit_info)
