extends Node2D  # Ensure the script extends Node2D or another relevant Node class

func _ready():
	var playerCharPath = Global.playerCharPath
	
	if NavigationManager.spawn_door_tag != null:	
		_on_level_spawn(NavigationManager.spawn_door_tag)
		
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
		
func _on_level_spawn(destination_tag: String):
	var door_path = "Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
