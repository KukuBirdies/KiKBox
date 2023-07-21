extends Node
# Global "Singleton", see Project Setting > Autoload

enum Weapons {PISTOL, RIFLE, SHOTGUN, GRENADE, KNIFE, GUN_MELEE}
var splash_weapons = [Weapons.GRENADE, Weapons.KNIFE]
var dmg = {
	Weapons.PISTOL: 10,
	Weapons.RIFLE: 20,
	Weapons.SHOTGUN: 10,
	Weapons.GRENADE: 50,
	Weapons.KNIFE: 50,
	Weapons.GUN_MELEE: 25
}


func pt_in_line_seg(line_pt1: Vector2, line_pt2: Vector2, pt: Vector2, epsilon: float=0.00001):
	# Check if a point within (inclusive) the line segment created by 2 given points
	print(line_pt1, line_pt2, pt)
	var pt1_to_p_normalized: Vector2 = (pt - line_pt1).normalized()
	var line_seg_normalized: Vector2 = (line_pt1 - line_pt2).normalized()
	
	# The dot product of these 2 vectors after normalising should be 1 (i.e. entirely projected onto)
	var is_colinear : bool = abs(abs(pt1_to_p_normalized.dot(line_seg_normalized)) - 1) < epsilon

	if not is_colinear:
		return false
	
	# Check if the point is within the segment (by checking only the x or y component based on
	# whether the line is more "horzontal" or "vertical")
	if abs(line_seg_normalized.y) > abs(line_seg_normalized.x):	# If the line is more "vertical" than "horzontal"
		return min(line_pt1.y, line_pt2.y) <= pt.y and pt.y <= max(line_pt1.y, line_pt2.y)
	else:
		return min(line_pt1.x, line_pt2.x) <= pt.x and pt.x <= max(line_pt1.x, line_pt2.x)
