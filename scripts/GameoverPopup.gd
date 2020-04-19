extends Popup

func _on_PlayAgainButton_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_MainMenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/MainMenu.tscn")
