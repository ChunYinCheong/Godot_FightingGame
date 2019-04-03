extends "res://states/State.gd"

export(int) var damage = 20
export(Vector2) var knockback = Vector2(50,0)
export(float) var hit_stun = 0.25
export(bool) var knockdown = false

var hitted = {}

func enter(character: Character):	
	.enter(character)
	self.hitted.clear()
	character.hit_box.monitoring = true
	pass
	
func exit(character,dict=null):
	character.hit_box.monitoring = false
	pass

func hit(character,area_id, area, area_shape, self_shape):
	if area.has_method("on_hit") and not self.hitted.has(area_id):
		self.hitted[area_id] = true
		#var damage = 0
		var _knockback = Vector2(knockback.x * character.facing, knockback.y)
		var knockback_source = self
		area.on_hit(area_shape, character, damage, hit_stun, _knockback, knockback_source, knockdown)
	pass
