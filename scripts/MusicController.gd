extends Control

# Load the music player node
onready var _player = $AudioStreamPlayer

var playing: bool = false

enum MODE {
	NONE, NORMAL, FASTER, FASTEST
}

var current_song = 0

var main = "res://sounds/main.ogg"

var normal_prefix = "res://sounds/normal-"
var faster_prefix = "res://sounds/faster-"
var fastest_prefix = "res://sounds/fastest-"

var mode = MODE.NONE

func get_song_path(requested_mode, requested_song):
	var path = ""
	if requested_mode == MODE.NORMAL:
		path = normal_prefix + str(requested_song) + ".ogg"
	elif requested_mode == MODE.FASTER:
		path = faster_prefix + str(requested_song) + ".ogg"
	elif requested_mode == MODE.FASTEST:
		path = fastest_prefix + str(requested_song) + ".ogg"
	else:
		print("UNKNOWN SONG MODE")
		
	print(path)
	return path

func set_song_for_remaining_time(time, song, force=false):
	var new_mode = mode
	if time > 40:
		new_mode = MODE.NORMAL
	elif time > 20:
		new_mode = MODE.FASTER
	elif time > -1:
		new_mode = MODE.FASTEST
		
	if new_mode != mode or force == true:
		play_track(get_song_path(new_mode, song))
			
	mode = new_mode

func play():
	playing = true
	_player.play()
	
# Calling this function will load the given track, and play it
func play_track(track_url : String):
	var track = load(track_url)
	_player.set_volume_db(-10) 
	_player.stream = track
	self.play()

# Calling this function will stop the music
func stop():
	playing = false
	_player.stop()
