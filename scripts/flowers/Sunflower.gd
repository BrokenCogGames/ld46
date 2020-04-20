extends "res://scripts/Plant.gd"

func _ready():
	$Waterbar.max_water_set(150)
	$Waterbar.current_water_set(150)
	drain_per_tick = 5
	aphid_drain_multiplier = 1.5
	watering_rate = 80.0
