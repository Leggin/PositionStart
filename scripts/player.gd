class_name Player
extends CharacterBody2D

@export var max_speed = 20
@export var health = 100
@export var shield = 1
@export var hit_damage = 10

var screen_size
var is_started = false
signal health_changed(old_value: int, new_value: int)

func _ready():
	screen_size = get_viewport_rect().size
	
	
func _process(delta):
	if is_started:
		$AnimatedSprite2D.play()
		#var velocity = Vector2(0, -1) 
		velocity += Vector2(0, -0.4) 
		#velocity = velocity.normalized() * speed
		#velocity = velocity.normalized() 
		print(velocity)
		#position += velocity * delta
		#position = position.clamp(Vector2.ZERO, screen_size)
		
		#velocity.y += gravity * delta
		velocity.y = clamp(velocity.y, -max_speed, max_speed)
		velocity.x = clamp(velocity.x, -1, 1)
		print(velocity)
		var bounce_strength = 0.8
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal()) * bounce_strength
			print("eee",velocity)
			var body = collision.get_collider()
			if body.has_method("is_enemy"):
				apply_damage(body.damage)
				body.apply_damage(hit_damage)
		

func start(x: int):
	is_started = true
	position = Vector2(x, position.y)

func apply_damage(damage: int):
	print("apply dammage", damage)
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
#func _on_body_entered(body: Node):
	#if body is Enemy:
		#apply_damage(body.damage)
		#health_changed.emit(shield, health)
