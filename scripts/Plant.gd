class_name Plant
extends StaticBody2D

var drain_per_tick = 2

func _ready():
	$Waterbar.current_water = $Waterbar.max_water

func _on_Timer_timeout():
	$Waterbar.current_water -= drain_per_tick
	if $Waterbar.current_water <= 0:
		print("IM DEAD!")

func add_water(water: float):
	$Waterbar.current_water += water