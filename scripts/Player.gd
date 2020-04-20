extends KinematicBody2D

export var water_per_decisecond = 5

var spigot
var stung: bool = false
var in_water: bool = false
var on_raft: bool = false
var alive: bool = true
var raft_entity: Raft = null
var invincible: bool = false
var in_water_counter: int = 0
var in_water_max_count: int = 4

# Player movement speed
export var deceleration = 3
export var acceleration = 3
export var top_speed = 3

var current_velocity = Vector2()
var current_direction_x = 0
var current_direction_y = 0
var current_speed_x = 0
var current_speed_y = 0

func _input(event):
	if event.is_action_released("ui_select"):
		if spigot:
			spigot.stop()
		$WateringSoundFX.stop()

func input():
	var input = Vector2()
	var is_moving_horizontally = false
	var is_moving_vertically= false
	if Input.is_action_pressed('ui_right') or Input.is_action_pressed('ui_left'):
		is_moving_horizontally = true
	
	if Input.is_action_pressed('ui_up') or Input.is_action_pressed('ui_down'):
		is_moving_vertically = true
		
	if current_velocity != Vector2(0,0):
		# Physically moving
		pass
	else:
		# Not physically moving
		pass

	if Input.is_action_pressed("ui_left"):
		if current_velocity.x > -top_speed:
			current_velocity.x -= acceleration
		current_direction_x = -1
	elif Input.is_action_pressed("ui_right"):
		if current_velocity.x < top_speed:
			current_velocity.x += acceleration
		current_direction_x = 1
		
	if Input.is_action_pressed("ui_up"):
		if current_velocity.y > -top_speed:
			current_velocity.y -= acceleration
		current_direction_y = -1
	elif Input.is_action_pressed("ui_down"):
		if current_velocity.y < top_speed:
			current_velocity.y += acceleration
		current_direction_y = 1

	# If we aren't moving intentionally but we're still sliding, we start to decelerate.
	if is_moving_horizontally == false and (current_velocity.x != 0 or current_velocity.y != 0):
		if current_direction_x == -1:
			current_velocity.x += deceleration
			if current_velocity.x > 0:
				current_velocity.x = 0
		if current_direction_x == 1:
			current_velocity.x -= deceleration
			if current_velocity.x < 0:
				current_velocity.x = 0
	
	if is_moving_vertically == false and (current_velocity.x != 0 or current_velocity.y != 0):
		if current_direction_y == -1:
			current_velocity.y += deceleration
			if current_velocity.y > 0:
				current_velocity.y = 0
		if current_direction_y == 1:
			current_velocity.y -= deceleration
			if current_velocity.y < 0:
				current_velocity.y = 0

func _physics_process(delta):
	# Get player input
	var direction: Vector2
	
	input()
	
	if stung == false:
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	elif stung == true:
		current_velocity.x = 0
		current_velocity.y = 0
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
	
	# Check for death
	if position.x < 0 or position.x > get_viewport_rect().size.x or position.y < 0 or position.y > get_viewport_rect().size.y:
		print("You left map")
		alive = false

	if raft_entity != null:
		current_velocity += raft_entity.velocity
	if current_velocity.x > top_speed:
		current_velocity.x = top_speed
	if current_velocity.y > top_speed:
		current_velocity.y = top_speed
	if current_velocity.x < -top_speed:
		current_velocity.x = -top_speed
	if current_velocity.y < -top_speed:
		current_velocity.y = -top_speed

	move_and_collide(current_velocity)

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
				if applied_water > 0 and $WateringSoundFX.playing == false:
					$WateringSoundFX.play()
				
		if by_spigot == true:
			$Waterbar.current_water += water_per_decisecond
	
	if in_water == true and on_raft == false and alive == true:
		in_water_counter += 1
		if in_water_counter >= in_water_max_count:
			alive = false
	else:
		in_water_counter = 0
	
	var bodies = $SquishArea.get_overlapping_bodies()
	for body in bodies:
		# Check to see if we are by a spigot
		if body.name == "AphidSwarm":
			body.queue_free()
	
func _player_stung():
	if stung == false && invincible == false:
		stung = true
		invincible = true
		$stung_wait.start()

func _on_stung_wait_timeout():
	stung = false
	$StungInvincibility.start()

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

func _on_DetectArea_body_exited(body):
	var spigot := body as Spigot
	if spigot != null:
		spigot.stop()
	var plant := body as Plant
	if plant != null:
		$WateringSoundFX.stop()


func _on_StungInvincibility_timeout():
	invincible = false
