extends Control

# Load the music player node
onready var _player = $AudioStreamPlayer

var playing: bool = false

func play():
	playing = true
	_player.play()
	
# Calling this function will load the given track, and play it
func play_track(track_url : String):
	print(track_url)
	var track = load(track_url)
	_player.stream = track
	self.play()

# Calling this function will stop the music
func stop():
	playing = false
	_player.stop()
