extends KinematicBody2D

# Player movement speed
export var speed = 100

var closest_flower: Vector2

func _physics_process(delta):
	# Get player input
	var direction: Vector2
	$AnimationPlayer.play("down")

	if closest_flower != Vector2(0, 0):
		direction = (closest_flower - position).normalized()
	# Apply movement
	var movement = speed * direction * delta
	if closest_flower != Vector2(0, 0):
		move_and_collide(movement)

func _on_TickCounter_timeout():
	var bodies = $DetectArea.get_overlapping_bodies()
	var current_closest_flower
	var working_flower
	var current_position = self.position
	var first = false
	for body in bodies:
		# Find the nearest plant
		var plant := body as Plant
		if plant != null:
			if first != true:
				first = true
				current_closest_flower = body.position
			var distance_to = body.position.distance_to(position)
			if distance_to < current_closest_flower.distance_to(position):
				current_closest_flower = body.position
	if current_closest_flower != null:
		self.closest_flower = current_closest_flower


func _on_Timer_timeout():
	var bodies = $PlantDrainArea.get_overlapping_bodies()
	for body in bodies:
		var plant := body as Plant
		if plant != null:
			plant.drain_water(plant.drain_per_tick * (plant.aphid_drain_multiplier-1))
