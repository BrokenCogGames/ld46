extends TextureButton

export var level: int = 1
export var locked: bool = false

func _on_LevelButton_pressed():
	print("You clicked on level %s" % level)
	get_tree().change_scene("res://scenes/Level_%d.tscn" % level)
	
func _ready():
	if locked:
		self.disabled = true
