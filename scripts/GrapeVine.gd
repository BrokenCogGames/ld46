extends "res://scripts/Plant.gd"

func _ready():
	$Waterbar.max_water_set(200)
	$Waterbar.current_water_set(200)
	drain_per_tick = 5
