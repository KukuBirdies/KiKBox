extends Node2D

@onready var Tracer := preload("res://scenes/tracer.tscn")
@onready var BulletImpactFX := preload("res://scenes/bullet_impact_fx.tscn")
@onready var player: CharacterBody2D = $Player
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	print("Mouse Hidden")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print(get_viewport().get_mouse_position(), get_global_mouse_position())
	#print(Global.pt_in_line_seg($Marker2D.global_position, $Marker2D2.global_position, get_global_mouse_position()))


func _on_player_shot_fired(weapon: Global.Weapons, ray_hit_info: RayHitInfo):
	# ray_hit_info: The ray cast hit info signalled by the player
	print("Level: Player Fired")
	ray_hit_info.print_info()
	
	# Tracer
	var tracer := Tracer.instantiate()
	if ray_hit_info.collider:
		tracer.set_point_position(1, Vector2(ray_hit_info.dist, 0))	# Sets the end of the tracer line
	else:
		tracer.set_point_position(1, Vector2(1920, 0))
	tracer.global_position = ray_hit_info.from
	tracer.global_rotation = ray_hit_info.global_rotation
	add_child(tracer)	# Auto-frees in function
	
	# Bullet Impact
	if ray_hit_info.collider:
		var bullet_impact_fx := BulletImpactFX.instantiate()
		bullet_impact_fx.global_position = ray_hit_info.to
		bullet_impact_fx.global_rotation = ray_hit_info.normal.angle()
		add_child(bullet_impact_fx)		# Auto-frees in animation
	
	
