extends "res://states/State.gd"

export(int) var damage = 100
export(Vector2) var knockback = Vector2(50,0)
export(float) var hit_stun = 0.4
export(bool) var soft_knockdown = false
export(bool) var hard_knockdown = false

var hitted = {}

func enter(character: Character):	
	.enter(character)
	self.hitted.clear()
	character.hit_box.monitoring = true
	pass
	
func exit(character):
	.exit(character)
	character.hit_box.monitoring = false
	pass

func hit(character,area_id, area, area_shape, self_shape):
	if area.has_method("on_hit") and not self.hitted.has(area_id):
		self.hitted[area_id] = true
		#var damage = 0
		var _knockback = Vector2(knockback.x * character.facing, knockback.y)
		var knockback_source = self
		var dict : Dictionary = {}
		dict.area_shape = area_shape
		dict.hit_by = character
		dict.damage = damage
		dict.hit_stun = hit_stun
		dict.knockback = _knockback
		dict.knockback_source = knockback_source
		dict.soft_knockdown = soft_knockdown
		dict.hard_knockdown = hard_knockdown
#		area.on_hit(area_shape, character, damage, hit_stun, _knockback, knockback_source, knockdown)
		area.on_hit(dict)
	pass
