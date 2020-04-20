extends "res://scripts/Plant.gd"

func _ready():
	$Waterbar.max_water_set(80)
	$Waterbar.current_water_set(80)
	drain_per_tick = 4
	aphid_drain_multiplier = 2
