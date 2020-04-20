extends "res://scripts/Plant.gd"

func _ready():
	$Waterbar.max_water_set(150)
	$Waterbar.current_water_set(150)
	drain_per_tick = 5
