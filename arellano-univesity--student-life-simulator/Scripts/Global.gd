extends Node

var playerCharPath: String
var player1_name = "Player 1"
var player2_name = "Player 2"
var previous_scene = ""  # Stores the previous scene path

# Function to change scenes while saving the previous one
func change_scene_with_history(scene_path: String):
	if get_tree().current_scene:
		var current_scene_path = get_tree().current_scene.scene_file_path
		if scene_path != current_scene_path:  # Prevent saving settings as previous scene
			previous_scene = current_scene_path
			print("Stored previous scene:", previous_scene)  # Debugging output
	get_tree().change_scene_to_file(scene_path)
