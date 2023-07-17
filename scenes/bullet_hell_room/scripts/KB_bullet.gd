extends Area2D

class_name Rocket

@export var explosion:PackedScene # Allow us to choose a scene to be used in this current node
@onready var spawn_point: Marker2D = $Marker2D

var speed: float = 25.0 
var spawned_from: Node
var time_to_live: float = 10


func _ready() ->void: 
	handle_time_to_live()


# to remove projectile 
func handle_time_to_live() ->void: 
	var ttl_timer: Timer = Timer.new() # instanitiate a new timer node
	add_child(ttl_timer) # add it to the scene
	ttl_timer.wait_time = time_to_live # timer value 
	ttl_timer.one_shot = true # one timer 
	ttl_timer.timeout.connect(func(): queue_free()) # what to do after timeout
	ttl_timer.start() #start timer 


# movements of projectile 
func _physics_process(_delta: float) -> void:
	position += transform.x * speed # transform.x is the relaitve x coodd


# effect of projectile
func on_body_entered(body: Node2D) ->void: 
	if body is TileMap: 
		queue_free


func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox and area.entity is Player: 
		queue_free()
		var ex : Explosion = explosion.instantiate()
		get_parent().call_deferred("add_child", ex) 
		ex.global_transform = spawn_point.global_transform
		
