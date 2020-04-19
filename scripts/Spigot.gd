class_name Spigot
extends StaticBody2D

var running: bool = false
var stop: bool = false

func _process(delta):
	if stop == true and running == true:
		stop = false
		_stop()

func start():
	if running == false:
		running = true
		$WaterStartSoundFX.play()
		$AnimationPlayer.play("start")
		yield($WaterStartSoundFX, "finished")
		
		# Counter is to ensure stale yields dont play
		if running == true:
			$WaterRunningSoundFX.play()
			$AnimationPlayer.play("running")
		
		
func stop():
	if running == true:
		stop = true
		
func _stop():
	if running == true:
		running = false
		$WaterRunningSoundFX.stop()
		$WaterStopSoundFX.play()
		$AnimationPlayer.play("stop")
		yield($AnimationPlayer, "animation_finished")
