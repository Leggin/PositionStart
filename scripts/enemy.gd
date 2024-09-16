class_name Enemy
extends RigidBody2D

@export var health = 1
@export var damage = 1
@export var speed = 1
@export var xp = 1

signal release_xp

var screen_size
var logic
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	logic = get_tree().get_nodes_in_group("Gameloop")[0]
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move(delta)

func move(delta: float) -> void:
	push_error("NOT IMPLEMENTED ERROR: enemy.move()")

func apply_damage(damage: int):
	push_error("NOT IMPLEMENTED ERROR: enemy.apply_damage()")


func _on_body_entered(body: Node):
	if body is Player:
		apply_damage(body.damage)

func is_enemy():
	return true

func die():
	health = 0
	logic.give_xp(xp)
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
