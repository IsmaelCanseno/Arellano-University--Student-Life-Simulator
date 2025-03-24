extends Node

const scene_neighborhood = preload("res://Scenes/neighborhood.tscn")
const scene_house = preload("res://Scenes/house.tscn")
const scene_schoolGrounds = preload("res://Scenes/schoolGrounds.tscn")
const scene_schoolHallway = preload("res://Scenes/schoolHallway.tscn")
const scene_prelimRoom = preload("res://Scenes/prelimRoom.tscn")
const scene_midtermRoom = preload("res://Scenes/midtermRoom.tscn")
const scene_semiRoom = preload("res://Scenes/semiRoom.tscn")
const scene_finalsRoom = preload("res://Scenes/finalsRoom.tscn")

const scene_prelimTask = preload("res://Game Tasks/prelim.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(Level_tag, destination_tag):
	var scene_to_load
	
	match Level_tag:
		"neighborhood":
			scene_to_load = scene_neighborhood
		"house":
			scene_to_load = scene_house
		"schoolGrounds":
			scene_to_load = scene_schoolGrounds
		"schoolHallway":
			scene_to_load = scene_schoolHallway
		"prelimRoom":
			scene_to_load = scene_prelimRoom
		"midtermRoom":
			scene_to_load = scene_midtermRoom
		"semiRoom":
			scene_to_load = scene_semiRoom
		"finalsRoom":
			scene_to_load = scene_finalsRoom
		"prelim":
			scene_to_load = scene_prelimTask

	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)
		
func trigger_player_spawn(position: Vector2, direction: String):
		on_trigger_player_spawn.emit(position, direction)
