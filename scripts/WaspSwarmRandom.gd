extends KinematicBody2D

# Player movement speed
export var speed = 200

var spigot

func _input(event):
	if event.is_action_released("ui_select"):
		if spigot:
			spigot.stop()

var position1 = Vector2(100, 100)
var position2 = Vector2(400, 400)
var duration = 4

export(NodePath) var pathToSelf

func _ready():
	var node = get_node(pathToSelf)
	node.position = position1
	node.interpolate_property(node.position, 'transform/position', position1,
							  position2, duration, Tween.TRANS_QUAD, Tween.EASE_OUT)

func _physics_process(delta):
	var direction: Vector2
	$AnimationPlayer.play("down")
	
	# If input is digital, normalize it for diagonal movement
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction.y = 0
		#direction = direction.normalized()
	
	# Apply movement
	var movement = speed * direction * delta
	move_and_collide(movement)

func _on_TickCounter_timeout():
	var by_spigot = false
	var bodies = $DetectArea.get_overlapping_bodies()
	for body in bodies:
		# Check to see if we are attacking a player!
		if body.name == "Player":
			print("You've been stung!")
			body._player_stung()

