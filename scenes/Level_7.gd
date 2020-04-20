extends "res://scripts/Level.gd"

func _init():
	aphid_spawn_table = [{"spawn_position": Vector2(900,250), "tick_count": 50},
						{"spawn_position": Vector2(900,600), "tick_count": 30},
						{"spawn_position": Vector2(100,250), "tick_count": 15}]
