extends Sprite2D

@export var pistol_crosshair : Texture
@export var rifle_crosshair : Texture
@export var shotgun_crosshair : Texture
@export var grenade_crosshair : Texture
@export var knife_crosshair : Texture

@onready var crosshairs = {
	Global.Weapons.PISTOL: pistol_crosshair,
	Global.Weapons.RIFLE: rifle_crosshair,
	Global.Weapons.SHOTGUN: shotgun_crosshair,
	Global.Weapons.GRENADE: grenade_crosshair,
	Global.Weapons.KNIFE: knife_crosshair,
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = get_global_mouse_position()


func set_crosshair(weapon : Global.Weapons):
	print("Changing crosshair to ", Global.Weapons.keys()[weapon], " using ", crosshairs[weapon])
	set_texture(crosshairs[weapon])
