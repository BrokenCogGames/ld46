extends StaticBody2D

var running: bool = false

func start():
	if running == false:
		running = true
		$AnimationPlayer.play("start")
		yield($AnimationPlayer, "animation_finished")
		$AnimationPlayer.play("running")
		
func stop():
	if running == true:
		running = false
		$AnimationPlayer.play("stop")
		yield($AnimationPlayer, "animation_finished")
		$AnimationPlayer.stop()
