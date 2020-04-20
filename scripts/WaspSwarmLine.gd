extends KinematicBody2D

# Player movement speed
export var speed = 200

var spigot

func _input(event):
	if event.is_action_released("ui_select"):
		if spigot:
			spigot.stop()

export var position1 = Vector2(100, 100)
export var position2 = Vector2(400, 400)

var flag = true

onready var node = get_node("Sprite")
onready var effect = get_node("Tween")

func _ready():
	self.position = position1

func _physics_process(delta):
	var direction: Vector2
	$AnimationPlayer.play("down")
	
	if(self.position <= position1 + Vector2(5, 5) && self.position >= position1 - Vector2(5, 5)):
		flag = true
		
	if(self.position <= position2 + Vector2(5, 5) && self.position >= position2 - Vector2(5,5)):
		flag = false
	
	if (flag):
		direction = self.position.direction_to(position2)
	else:
		direction = self.position.direction_to(position1)
	
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
