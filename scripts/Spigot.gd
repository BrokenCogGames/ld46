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
		print("before yield 1")
		yield($WaterStartSoundFX, "finished")
		print("before yield 2")
		#yield($AnimationPlayer, "animation_finished")
		#print("after yield 2")
		if running == true:
			$WaterRunningSoundFX.play()
			$AnimationPlayer.play("running")
		
		
func stop():
	stop = true
		
func _stop():
	if running == true:
		print("STOP WATER")
		running = false
		$WaterRunningSoundFX.stop()
		$WaterStopSoundFX.play()
		$AnimationPlayer.play("stop")
		yield($AnimationPlayer, "animation_finished")
		#$AnimationPlayer.stop()
