extends "res://scripts/Level.gd"

func _init():
	aphid_spawn_table = [{"spawn_position": Vector2(900,100), "tick_count": 50},
						{"spawn_position": Vector2(500,300), "tick_count": 40},
						{"spawn_position": Vector2(500,500), "tick_count": 30},
						{"spawn_position": Vector2(50,250), "tick_count": 20}]
