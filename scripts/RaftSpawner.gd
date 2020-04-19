extends Node2D

# Position where raft is spawned
export var start_position: Vector2 = Vector2(0, 0)

# Position where raft moves to
export var end_position: Vector2 = Vector2(0, 0)

# Movement speed of rafts
export var speed: float = 100.0

onready var raft_class = preload("res://scenes/Raft.tscn")

var raft: Raft = null

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	spawn_raft()
	
func spawn_raft():
	raft = raft_class.instance()
	raft.position = start_position
	self.add_child(raft)

func _physics_process(delta):
	if raft != null:
		var direction = end_position - raft.position
		raft.velocity = speed * direction.normalized() * delta
		raft.move_and_collide(raft.velocity)
		
		if raft.position.distance_to(end_position) < 1:
			raft.queue_free()
			raft = null
	else:
		spawn_raft()
