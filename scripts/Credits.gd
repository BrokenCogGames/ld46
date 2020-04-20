extends Node2D

func _ready():
	MusicController.play_track("res://sounds/main.ogg")

func _on_DelayTimer_timeout():
	$Tween.interpolate_property($Text, "position", $Text.position, $Text.position + Vector2(0, -2000), 8.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	get_tree().change_scene("res://scenes/MainMenu.tscn")
