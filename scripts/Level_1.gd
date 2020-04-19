extends "res://scripts/Level.gd"

func _init():
	aphid_spawn_table = [{"spawn_position": Vector2(300,300), "tick_count": 10},
						{"spawn_position": Vector2(400,400), "tick_count": 20}]

func _on_AphidSpawnTimer_timeout():
	aphid_tick_count += 1
	for aphid in aphid_spawn_table:
		if aphid.tick_count == aphid_tick_count:
			var scene = load("res://scenes/AphidSwarm.tscn")
			var scene_instance = scene.instance()
			scene_instance.set_name("AphidSwarm")
			scene_instance.position = aphid.spawn_position
			add_child(scene_instance)
