@icon("res://meta/health_manager_icon.svg")
class_name HealthManager
extends Node2D

@export var max_hp: int = 100
@export var hp: int = 100
var hp_ratio: float:
	get: return hp/max_hp
	set(ratio): hp = ratio * max_hp

func take_dmg(dmg: int):
	print("{owner} taking {dmg} damage".format({"owner": owner}))
	hp -= dmg
