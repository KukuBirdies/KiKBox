@icon("res://meta/health_manager_icon.svg")
class_name HealthManager
extends Node2D

signal died

@export var healthbar: Healthbar
@export var max_hp: int = 100
@export var hp: int = 100

var hp_ratio: float:
	get: return float(hp)/float(max_hp)
	set(ratio): hp = int(ratio * max_hp)

func _ready():
	if healthbar:
		healthbar.init_health(max_hp)

func take_dmg(dmg: int):
	hp -= dmg
	if hp <= 0:
		emit_signal("died")
	if healthbar:
		healthbar.update_hp(hp)
	
