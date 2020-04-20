extends "res://scripts/Plant.gd"

func _ready():
	$Waterbar.max_water_set(100)
	$Waterbar.current_water_set(100)
	drain_per_tick = 4
	aphid_drain_multiplier = 1.5
	watering_rate = 15.0
