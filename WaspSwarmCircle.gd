extends KinematicBody2D

export var RotateSpeed = 2.5
export var Radius = 80
var _centre
var _angle = 0

func _ready():
	set_process(true)
	_centre = self.position

func _physics_process(delta): 
	$AnimationPlayer.play("down")
	_angle += RotateSpeed * delta;
	var offset = Vector2(sin(_angle), cos(_angle)) * Radius;
	var pos = _centre + offset
	self.position = pos

func _on_TickCounter_timeout():
	var by_spigot = false
	var bodies = $DetectArea.get_overlapping_bodies()
	for body in bodies:
		# Check to see if we are attacking a player!
		if body.name == "Player":
			print("You've been stung!")

