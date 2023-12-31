class_name BaseLevel
extends Node2D

# All rooms that interacts with the player will inherit from
# player_interactable_room.tscn (with this script attached).
#
# All direct signals and communication between the player and level will go
# through this script before propagating into the respective custom levels.

@onready var Tracer := preload("res://scenes/bullets/tracer.tscn")
@onready var BulletHitFX := preload("res://scenes/bullets/dflt_wall_bullet_hit_fx.tscn")
@onready var player: CharacterBody2D = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	connect_player_signals(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func hurt_entities(entities: Array):
	for entity in entities:
		entity.hurt()
	
	
func hit_scan_attack(ray_hit_info: RayHitInfo, dmg: int, Tracer: PackedScene, BulletHitFX: PackedScene = BulletHitFX):
	# Renders tracer and bullet impact animation.
	# Tracer
	var tracer: Line2D = Tracer.instantiate()
	# Sets the end of the tracer line
	if ray_hit_info.collider:
		tracer.set_point_position(1, Vector2(ray_hit_info.dist, 0))
	else:
		tracer.set_point_position(1, Vector2(get_viewport_rect().size.x, 0))	# Sets a long tracer line
	tracer.global_position = ray_hit_info.from
	tracer.global_rotation = ray_hit_info.global_rotation
	add_child(tracer) 	# Frees after auto-playing
	
	# Bullet Impact
	if ray_hit_info.collider is Hurtbox:	# Entities can have their own bullet impact animation
		var hurtbox: Hurtbox = ray_hit_info.collider
		hurtbox.play_bullet_hit_fx(hurtbox.to_local(ray_hit_info.to), -ray_hit_info.dir)
		hurtbox.hurt(dmg, ray_hit_info.dir)
	elif ray_hit_info.collider:
		var bullet_impact_fx := BulletHitFX.instantiate()
		bullet_impact_fx.global_position = ray_hit_info.to
		bullet_impact_fx.global_rotation = (-ray_hit_info.dir).angle()
		add_child(bullet_impact_fx)		# Frees in auto-played animation

# Signal Handling from Player
func connect_player_signals(player):
	player.connect("ray_fired", _on_player_ray_fired)

func _on_player_ray_fired(dmg: int, ray_hit_info: RayHitInfo):
	# ray_hit_info: The ray cast hit info signalled by the player
	hit_scan_attack(ray_hit_info, dmg, Tracer, BulletHitFX)
	
