extends "res://states/State.gd"

export(float) var hit_damage = 100
export(float) var block_damage = 1
export(float) var hit_stun = 0.5
export(float) var block_stun = 0.1
export(Vector2) var hit_knockback = Vector2(50,0)
export(Vector2) var block_knockback = Vector2(50,0)
export(Vector2) var reknockback = Vector2(-50,0)
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
		
		var dict : Dictionary = {}
		dict.area_shape = area_shape
		dict.hit_by = character
		
		dict.hit_damage = hit_damage
		dict.hit_stun = hit_stun
		dict.block_damage = block_damage
		dict.block_stun = block_stun
		
		dict.knockback_source = character
		dict.hit_knockback = Vector2(hit_knockback.x * character.facing, hit_knockback.y)
		dict.block_knockback = Vector2(block_knockback.x * character.facing, block_knockback.y)
		dict.reknockback = Vector2(reknockback.x * character.facing, reknockback.y)
		
		dict.soft_knockdown = soft_knockdown
		dict.hard_knockdown = hard_knockdown
		area.on_hit(dict)
	pass
