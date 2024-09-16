
extends Enemy

@export var min_change_time: float = 4.5 # Minimum time before changing direction
@export var max_change_time: float = 10.0 # Maximum time before changing direction

var direction: Vector2 = Vector2(1, 0) # Initial direction (right)
var move_timer: float = 0.0 # Timer for switching direction

func _ready():
	super._ready()
	screen_size = get_viewport_rect().size
	speed = 8
	damage = 10
	xp = 2
	# Randomize the move_timer with a random value between the min and max time
	move_timer = randf_range(min_change_time, max_change_time)
	
	
func _process(delta: float) -> void:
	# Move the enemy in the current direction
	move_enemy(delta)

	# Update the timer and switch direction randomly when the timer is up
	move_timer -= delta
	if move_timer <= 0:
		change_direction()

func move_enemy(delta):
	# Move the enemy in the current direction (left or right)
	var velocity = direction * speed * delta
	position += velocity
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

func change_direction():
	# Randomly pick a new direction (left or right)
	if randi() % 2 == 0:
		direction = Vector2(1, 0) # Move right
	else:
		direction = Vector2(-1, 0) # Move left

	# Reset the timer for the next change
	move_timer = randf_range(min_change_time, max_change_time)

func apply_damage(damage: int):
	health = health - damage
	if health <= 0:
		die()
