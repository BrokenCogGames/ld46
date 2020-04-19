extends Control

# Load the music player node
onready var _player = $AudioStreamPlayer

var playing: bool = false

enum MODE {
	NONE, NORMAL, FASTER, FASTEST
}

var main = "res://sounds/main.ogg"
var normal = "res://sounds/normal.ogg"
var faster = "res://sounds/faster.ogg"
var fastest = "res://sounds/fastest.ogg"

var mode = MODE.NONE

func set_song_for_remaining_time(time, force=false):
	var new_mode = mode
	if time > 40:
		new_mode = MODE.NORMAL
	elif time > 20:
		new_mode = MODE.FASTER
	elif time > -1:
		new_mode = MODE.FASTEST
		
	if new_mode != mode or force == true:
		if new_mode == MODE.NORMAL:
			play_track(normal)
		elif new_mode == MODE.FASTER:
			play_track(faster)
		elif new_mode == MODE.FASTEST:
			play_track(fastest)
			
	mode = new_mode

func play():
	playing = true
	_player.play()
	
# Calling this function will load the given track, and play it
func play_track(track_url : String):
	var track = load(track_url)
	_player.stream = track
	self.play()

# Calling this function will stop the music
func stop():
	playing = false
	_player.stop()
