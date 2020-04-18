extends Node2D

onready var inside = get_node("Outside/Inside")

# max_water
export(int) var max_water = 100 setget max_water_set, max_water_get

func max_water_set(new_value):
	max_water = new_value
	inside.rect_scale.x = current_water / float(max_water)
	
func max_water_get():
	return max_water

# current_water
export(int) var current_water = 0 setget current_water_set, current_water_get

func current_water_set(new_value):
	current_water = clamp(new_value, 0, max_water)
	inside.rect_scale.x = current_water / float(max_water)

func current_water_get():
    return current_water

func _ready():
	inside.rect_scale.x = current_water / float(max_water)
