extends Node2D

func _ready():
	if MusicController.playing == false:
		MusicController.play_track("res://sounds/main_menu_theme.ogg")

func _on_PlayButton_pressed():
	var t = Timer.new()
	t.set_wait_time(0.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	get_tree().change_scene("res://scenes/SelectLevelMenu.tscn")
