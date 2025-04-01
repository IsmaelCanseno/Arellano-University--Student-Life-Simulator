extends Control


var player_name
var score = 0


func _on_button_pressed() -> void:
	score += 1
	$Button.text = str(score)

func _on_submitbtn_pressed() -> void:
	if $LineEdit.text != '':
		player_name = $LineEdit.text
		SilentWolf.Scores.save_score(player_name, score)
		get_tree().change_scene_to_file("res://addons/silent_wolf/Scores/Leaderboard.tscn")
			


func _on_back_to_main_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
