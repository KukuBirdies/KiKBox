class_name Healthbar
extends Control

# Simple Healthbar to, works with HealthManager by simply attaching a Healthbar instance
# onto the HealthManager node, all logic is handled by HealthManager.

@onready var lag_bar: TextureProgressBar = $LagBar
@onready var true_bar: TextureProgressBar = $TrueBar

func init_health(max_hp: int):
	true_bar.max_value = max_hp
	true_bar.value = max_hp
	lag_bar.max_value = max_hp
	lag_bar.value = max_hp

func update_hp(hp):
	true_bar.value = hp
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(lag_bar, "value", true_bar.value, 0.3)
