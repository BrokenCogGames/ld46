extends KinematicBody2D

# Player movement speed
export var speed = 200
export var water_per_decisecond = 5

var spigot
var stung: bool = false
var in_water: bool = false
var on_raft: bool = false
var alive: bool = true
var raft_entity: Raft = null

func _input(event):
	if event.is_action_released("ui_select"):
		if spigot:
			spigot.stop()
		$WateringSoundFX.stop()

func _physics_process(delta):
	# Get player input
	var direction: Vector2
	
	if stung == false:
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	elif stung == true:
		direction.x = 0
		direction.y = 0
	if direction.x > 0:
		$AnimationPlayer.play("right")
	elif direction.x < 0:
		$AnimationPlayer.play("left")
	elif direction.y > 0:
		$AnimationPlayer.play("down")
	elif direction.y < 0:
		$AnimationPlayer.play("up")
	else:
		$AnimationPlayer.stop(false)
		#$AnimationPlayer.play("idle")
	
	# If input is digital, normalize it for diagonal movement
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction.y = 0
		#direction = direction.normalized()
	
	# Check for death
	if position.x < 0 or position.x > get_viewport_rect().size.x or position.y < 0 or position.y > get_viewport_rect().size.y:
		print("You left map")
		alive = false
	
	# Apply movement
	var movement = speed * direction * delta
	if raft_entity != null:
		movement += raft_entity.velocity
	move_and_collide(movement)

func _on_TickCounter_timeout():
	if Input.is_action_pressed("ui_select"):
		var by_spigot = false
		var bodies = $DetectArea.get_overlapping_bodies()
		for body in bodies:
			# Check to see if we are by a spigot
			if body.name == "Spigot":
				by_spigot = true
				spigot = body
				spigot.start()
				
			# Check to see if we are by a plant
			var plant := body as Plant
			if plant != null:
				var applied_water = min($Waterbar.current_water, 5)
				plant.add_water(applied_water)
				$Waterbar.current_water -= applied_water
				if $WateringSoundFX.playing == false:
					$WateringSoundFX.play()
				
		if by_spigot == true:
			$Waterbar.current_water += water_per_decisecond
	
	if in_water == true and on_raft == false and alive == true:
		print("You drowned")
		alive = false
			
func _player_stung():
	if stung == false:
		stung = true
		$stung_wait.start()

func _on_stung_wait_timeout():
	stung = false

func _on_WaterDetectArea_body_entered(body):
	var raft := body as Raft
	if raft != null:
		raft_entity = raft
		on_raft = true
	if body.name == "layer_1":
		in_water = true

func _on_WaterDetectArea_body_exited(body):
	var raft := body as Raft
	if raft != null:
		raft_entity = null
		on_raft = false
	if body.name == "layer_1":
		in_water = false
