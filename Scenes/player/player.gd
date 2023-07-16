class_name Player
extends CharacterBody2D

# Player interacts with the room (bullet/projectiles/etc) strictly through the
# PlayerInteractableRoom it is in - All rooms that want to interact with the
# player will inherit from player_interactable_room.tscn
# 
# Signal connection are the job of 

signal shot_fired(weapon: String, ray_hit_info: RayHitInfo)

const MAXSPEED = 300.0
const ACCELERATION = 0.4	# 1 means instant acceleration
const FRICTION = 0.2		# 1 means instant deceleration

@onready var anim_state_machine = $AnimationPlayer/AnimationTree.get("parameters/playback")
@onready var aim_from: Node2D = $AimFrom
@onready var crosshair: Sprite2D = $Crosshair
@onready var raycast: Node2D = $Barrel/RayCast2D

var weapon := Global.Weapons.PISTOL
var player_gun_offset: int

func _ready():
	assert(aim_from.position.x == 0)	
	player_gun_offset = aim_from.position.y
	print("Gun Offset (should be 21): ", player_gun_offset)


func _physics_process(_delta):
	aim()
	# Movement
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	direction = direction.normalized()

	if direction:
		velocity = velocity.lerp(direction * MAXSPEED, ACCELERATION)	# Exponentially accelerate
		anim_state_machine.travel(weapon_ani_name(weapon, "move"))
	else:
		velocity = velocity.lerp(Vector2.ZERO, FRICTION)	# Exponentially decelerate
		anim_state_machine.travel(weapon_ani_name(weapon, "idle"))
	
	if Input.is_action_just_pressed("melee"):
		melee()
	elif Input.is_action_pressed("attack"):
		# Fire rate and action is handled in AnimationPlayer :D
		anim_state_machine.travel(weapon_ani_name(weapon, "shoot"))
	
	#print("Currently Playing: ", anim_state_machine.get_current_node())
	raycast.force_raycast_update()	# Effects of not doing this is amplified when we rotate very quickly
	move_and_slide()	# Intrinsically handles delta

func aim():
	# Rotates player such that gun aims at crosshair
	var offset_angle = atan2(player_gun_offset, global_position.distance_to(crosshair.global_position))
#	print(aim_from.get_angle_to(crosshair.global_position))
	rotate(get_angle_to(crosshair.global_position) - offset_angle)	# get_angle_to takes in global coords, and has a sense of "front" for a Node2D
		#rotate(aim_from.get_angle_to(crosshair.global_position))	# WRONG! Quite funny it still converges and works
func melee():
	anim_state_machine.travel(weapon_ani_name(weapon, "melee"))
	crosshair.set_crosshair(Global.Weapons.RIFLE)
	print("Melee attack with %s" % weapon)
	
func attack():
	# Called by AnimationPlayer
	print("Player: Attacked with %s" % (Global.Weapons.keys()[weapon]).to_lower())
	emit_signal("shot_fired", weapon, RayHitInfo.new(raycast))

func weapon_ani_name(weapon: Global.Weapons, action: String):
	# Get animation name used in AnimationPlayer
	# Weapons: pistol, rifle, shotgun, knife
	var weapon_str: String = (Global.Weapons.keys()[weapon]).to_lower()
	return "%s_%s" % [weapon_str, action]
