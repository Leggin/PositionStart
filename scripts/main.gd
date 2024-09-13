extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		$Player.start(event.position.x)
	elif !$Player.is_started && event is InputEventMouseMotion:
		$Player.position.x = event.position.x
		

func give_xp(value: int):
	$Player.gain_xp(value)
