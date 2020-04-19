extends Popup

var next_level: int = 0

func _on_NextLevelButton_pressed():
	get_tree().paused = false
	print("res://scenes/Level_%d.tscn" % next_level)
	get_tree().change_scene("res://scenes/Level_%d.tscn" % next_level)

func _on_MainMenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/MainMenu.tscn")
