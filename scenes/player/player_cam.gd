extends Camera2D

@export var crosshair: Node2D

@export var tremor := 0.0
@export var tremor_drop_rate := 1.0
@export var tremor_offset: Vector2
@export var max_tremor_offset := Vector2(100, 100)

@export var noise: FastNoiseLite
@export var noise_speed := 3	# noise_speed*time(ms) will be used to scan the x-axis of the noise for smooth rng

func _ready():
	EventBus.connect("player_cam_add_tremor", add_tremor)
	noise.seed = randi()

func _process(delta):
	# Camera shift with aim effect
	var aim_offset: Vector2 = (crosshair.global_position - global_position) / 20
	aim_offset.y *= 1.2		# To compensate for the lack of screen space to aim in the y-axis
	
	# tremor (Camera Shake)
	tremor_offset.x = noise.get_noise_2d(0, noise_speed*Time.get_ticks_msec()) * _shake_intensity(tremor) * max_tremor_offset.x
	tremor_offset.y = noise.get_noise_2d(1000, noise_speed*Time.get_ticks_msec()) * _shake_intensity(tremor) * max_tremor_offset.y
	tremor_offset.y = noise.get_noise_2d(2000, noise_speed*Time.get_ticks_msec()) * _shake_intensity(tremor) * max_tremor_offset.y
	tremor = move_toward(tremor, 0, delta*tremor_drop_rate)
	
	offset = aim_offset + tremor_offset

func add_tremor(added_tremor: float):
	# Adds tremor to the camera shake effect
	tremor = clampf(tremor + added_tremor, 0, 1)

func _shake_intensity(tremor):
	# Quadratic Easing
	return tremor * tremor
