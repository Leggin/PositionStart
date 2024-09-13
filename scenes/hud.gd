extends CanvasLayer


var player: Player

# Called when the node enters the scene tree for the first time.

func adapt_health_value(shield_health: int, health: int):
	$HealthBar.value = health
	$ShieldBar.value = shield_health
	set_bar_colors(shield_health, health)

func adapt_xp_value(xp: int, max_xp: int):
	$XPBar.value = xp
	$XPBar.max_value = player.max_exp

func adapt_level():
	$LevelText.text = str(int($LevelText.text) + 1)
	
func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]
	$HealthBar.max_value = player.health
	$HealthBar.value = player.health
	$ShieldBar.max_value = player.shield
	$ShieldBar.value = player.shield
	$XPBar.max_value = player.max_exp
	player.health_changed.connect(adapt_health_value)
	player.xp_changed.connect(adapt_xp_value)
	player.level_increased.connect(adapt_level)


func set_bar_colors(shield_health: int, health: int):
	var style_box = $HealthBar.get_theme_stylebox("custom_styles/bg")
	style_box.bg_color.h = lerp(0.0, 0.3, health / $HealthBar.max_value)
	#$ShieldBar.bg_color.h = lerp(0.0, 0.3, shield_health / $ShieldBar.max_value)
