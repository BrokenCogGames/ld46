class_name Plant
extends StaticBody2D

export var drain_per_tick = 2
export var aphid_drain_multiplier = 1.5
var alive: bool = true

func _ready():
	$Waterbar.current_water = $Waterbar.max_water
	$AnimationPlayer.play("idle")

func _on_Timer_timeout():
	drain_water(drain_per_tick)

func add_water(water: float):
	if alive == true:
		$Waterbar.current_water += water
	
func drain_water(water: float):
	$Waterbar.current_water -= drain_per_tick
	if $Waterbar.current_water <= 0:
		alive = false
