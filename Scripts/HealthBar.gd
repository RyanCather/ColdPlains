extends CanvasLayer

@onready var health_label = $HealthLabel
var player


func _ready():
	# Get the parent player node
	player = get_parent()
	
	print("HealthBar _ready() called for player:", player.name)
	print("Is this the local player authority?", player.is_multiplayer_authority())
	
	# Only show UI for the local player
	if not player.is_multiplayer_authority():
		print("This is NOT the local player, hiding HealthBar")
		visible = false
		return
	
	print("This IS the local player, setting up HealthBar")
	
	# Connect to the signal FIRST, before anything else
	player.health_changed.connect(_on_health_changed)
	print("Connected to health_changed signal")
	
	# Set label text color to white
	health_label.add_theme_color_override("font_color", Color.WHITE)
	
	# Set label background to green
	var panel_style = StyleBoxFlat.new()
	panel_style.bg_color = Color.GREEN
	panel_style.set_corner_radius_all(5)
	panel_style.set_content_margin_all(10)
	health_label.add_theme_stylebox_override("normal", panel_style)
	
	# Set initial value
	health_label.text = str(player.health) + " / 100"
	print("Initial health label text set to:", health_label.text)
	print("HealthBar setup complete!")


func _on_health_changed(new_health):
	print("=== _on_health_changed CALLED ===")
	print("new_health:", new_health)
	print("health_label ref:", health_label)
	
	if health_label == null:
		print("ERROR: health_label is null!")
		return
	
	health_label.text = str(new_health) + " / 100"
	print("Health label text updated to:", health_label.text)
	print("Health label visible:", health_label.visible)
