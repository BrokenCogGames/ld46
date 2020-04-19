extends Node2D

func _ready():
	if MusicController.playing == false or MusicController.mode != MusicController.MODE.NONE:
		MusicController.play_track(MusicController.main)
		MusicController.mode = MusicController.MODE.NONE
		
	# Decide which levels are unlocked...
	var children = $CenterContainer/GridContainer.get_children()
	for child in children:
		print(child)
		var levelbutton := child as LevelButton
		if levelbutton != null:
			if levelbutton.level > LevelManager.unlocked_levels:
				levelbutton.disabled = true
			else:
				levelbutton.disabled = false

func _on_BackButton_pressed():
	var t = Timer.new()
	t.set_wait_time(0.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	get_tree().change_scene("res://scenes/MainMenu.tscn")
