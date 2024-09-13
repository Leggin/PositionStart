extends CanvasLayer


var player: Player

# Called when the node enters the scene tree for the first time.

func adapt_health_value(shield_health: int, health: int):
	$HealthBar.value = health
	$HealthPoints.text = str(health)
	$ShieldBar.value = shield_health
	set_bar_colors(shield_health, health)


func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]
	print(player.health)
	$HealthBar.max_value = player.health
	$HealthBar.value = player.health
	$ShieldBar.max_value = player.shield
	$ShieldBar.value = player.shield
	$HealthPoints.text = str(player.health)
	player.health_changed.connect(adapt_health_value)


func set_bar_colors(shield_health: int, health: int):
	var style_box = $HealthBar.get_theme_stylebox("custom_styles/fg")
	style_box.bg_color.h = lerp(0.0, 0.3, health / $HealthBar.max_value)
	#$ShieldBar.bg_color.h = lerp(0.0, 0.3, shield_health / $ShieldBar.max_value)
