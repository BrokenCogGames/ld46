extends Node2D

# Goal time in seconds
export var goal_time: int = 60
export var level: int = 0

func _ready():
	MusicController.set_song_for_remaining_time(goal_time, true)
	$GoalTimer.wait_time = goal_time
	$GoalTimer.start()

func _input(event):
	if event.is_action_released("ui_cancel"):
		get_tree().change_scene("res://scenes/SelectLevelMenu.tscn")

func win():
	get_tree().paused = true
	var next_level = level+1
	LevelManager.unlocked_levels = next_level
	$Canvas/WinPopup.next_level = next_level
	$Canvas/WinPopup.popup()

func beat_game():
	pass

func gameover():
	get_tree().paused = true
	$Canvas/GameoverPopup.popup()

func get_time_remaining():
	var sec_left = $GoalTimer.time_left
	var min_left = int(floor(sec_left / 60))
	sec_left = sec_left - min_left * 60
	return "%02d:%02d" % [min_left, sec_left]

func _process(delta):
	if $Player.alive == false:
		gameover()
		
	# Update timer
	$Canvas/TimeRemainingLabel.text = get_time_remaining()
	MusicController.set_song_for_remaining_time($GoalTimer.time_left)
	
	var children = get_children()
	for child in children:
		var plant := child as Plant
		if plant != null:
			if plant.alive == false:
				gameover()

func _on_GoalTimer_timeout():
	if level >= 8:
		beat_game()
	else:
		win()
