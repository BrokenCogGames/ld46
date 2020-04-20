extends "res://scripts/Level.gd"

func _init():
	aphid_spawn_table = [{"spawn_position": Vector2(100,100), "tick_count": 20},
						{"spawn_position": Vector2(900,600), "tick_count": 30},
						{"spawn_position": Vector2(400,100), "tick_count": 55}]
