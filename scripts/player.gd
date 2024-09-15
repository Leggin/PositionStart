class_name Player
extends CharacterBody2D

@export var max_speed = 20
@export var health = 100
@export var shield = 1
@export var hit_damage = 10
@export var current_exp = 0
@export var max_exp = 10

var screen_size
var is_started = false
signal health_changed(old_value: int, new_value: int)
signal xp_changed(current: int, max: int)
signal level_increased()

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	if is_started:
		$AnimatedSprite2D.play()
		velocity += Vector2(0, -0.4) 

		velocity.y = clamp(velocity.y, -max_speed, max_speed)
		velocity.x = clamp(velocity.x, -1, 1)
		var bounce_strength = 0.8
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal()) * bounce_strength
			var body = collision.get_collider()
			if body.has_method("is_enemy"):
				apply_damage(body.damage)
				body.apply_damage(hit_damage)
		

func start(x: int):
	is_started = true
	position = Vector2(x, position.y)

func apply_damage(damage: int):
	var rest = 0
	if not is_started:
		return
		
	if shield > 0:
		shield = shield - damage
		
		if shield < 0:
			rest = -shield
			
		if rest > 0:
			health = health - rest
			
	else:
		health = health - damage
	
	if health <= 0:
		health = 0
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
	
	health_changed.emit(shield, health)


func gain_xp(value: int):
	current_exp += value
	if current_exp >= max_exp:
		level_up()
		level_increased.emit()
		
	xp_changed.emit(current_exp, max_exp)

func level_up() -> void: 
	current_exp -= max_exp 
	max_exp = max_exp*2
	$AnimatedSprite2D.sprite_frames = load("res://assets/character/chicken/chicken.tres")
