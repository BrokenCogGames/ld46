extends "res://scripts/Plant.gd"

func _ready():
	$Waterbar.max_water_set(120)
	$Waterbar.current_water_set(120)
	drain_per_tick = 5
	aphid_drain_multiplier = 1.8
	watering_rate = 12.0
