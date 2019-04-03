extends Area2D

onready var character : Character = $".."

func on_hit(area_shape, hit_by, damage, hit_stun, knockback, knockback_source, knockdown):
	character.on_hit(area_shape, hit_by, damage, hit_stun, knockback, knockback_source, knockdown)
	pass