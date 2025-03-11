extends Node2D  # Ensure the script extends Node2D or another relevant Node class

func _ready():
	var playerCharPath = GlobalData.playerCharPath
	
	# Check if path exists
	if not ResourceLoader.exists(playerCharPath):
		print("Error: Invalid player character path!", playerCharPath)
		return

	var playerScene = load(playerCharPath)
	
	# Ensure scene is loaded properly
	if playerScene == null:
		print("Error: Failed to load player scene!")
		return

	var playerNode = playerScene.instantiate()
	add_child(playerNode)  # Ensure script extends Node to use this

	# Ensure Marker2D exists
	var marker = $Marker2D
	if marker == null:
		print("Error: Marker2D node not found!")
		return

	playerNode.global_position = marker.global_position
