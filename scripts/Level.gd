extends Node2D

# Goal time in seconds
export var goal_time: int = 60
export var level: int = 0
export var song: int = 0

func _ready():
	MusicController.set_song_for_remaining_time(goal_time, song, true)
	$GoalTimer.wait_time = goal_time
	$GoalTimer.start()

var aphid_tick_count = 0

var aphid_spawn_table = [{"spawn_position": Vector2(0,0), "tick_count": 0}]

func _input(event):
	if event.is_action_released("ui_cancel"):
		get_tree().change_scene("res://scenes/SelectLevelMenu.tscn")

func win():
	get_tree().paused = true
	var next_level = level+1
	LevelManager.unlocked_levels = next_level
	$Canvas/WinPopup.next_level = next_level
	$Canvas/WinPopup.show()

func beat_game():
	pass

func _on_AphidSpawnTimer_timeout():
	aphid_tick_count += 1
	for aphid in aphid_spawn_table:
		if aphid.tick_count == aphid_tick_count:
			var scene = load("res://scenes/AphidSwarm.tscn")
			var scene_instance = scene.instance()
			scene_instance.set_name("AphidSwarm")
			scene_instance.position = aphid.spawn_position
			add_child(scene_instance)


func gameover():
	get_tree().paused = true
	$Canvas/GameoverPopup.show()

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
	MusicController.set_song_for_remaining_time($GoalTimer.time_left, song)
	
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

