extends Node2D

func _ready():
	if MusicController.playing == false or MusicController.mode != MusicController.MODE.NONE:
		MusicController.play_track(MusicController.main)
		MusicController.mode = MusicController.MODE.NONE

func _on_PlayButton_pressed():
	var t = Timer.new()
	t.set_wait_time(0.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	get_tree().change_scene("res://scenes/SelectLevelMenu.tscn")
