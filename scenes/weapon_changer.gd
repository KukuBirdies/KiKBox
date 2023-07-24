extends Area2D



func _on_area_entered(area):
	print(area)
	if area is Hurtbox:
		var hurtbox:Hurtbox = area
		if hurtbox.entity is Player:
			var player: Player = hurtbox.entity
			print("CHANGE WEAPON")
			player.equip_weapon(Global.Weapons.RIFLE)
