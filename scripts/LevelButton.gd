extends TextureButton

var level_1_normal_texture = preload("res://assets/level-1.png")
var level_1_clicked_texture = preload("res://assets/level-1-clicked.png")

export var level: int = 1
export var locked: bool = false

func _on_LevelButton_pressed():
	print("You clicked on level %s" % level)
	
func _ready():
	self.texture_normal = level_1_normal_texture
	self.texture_pressed = level_1_clicked_texture
	if locked:
		self.disabled = true
