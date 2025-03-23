extends Control

@onready var name_input_p1 = $Player1/LineEdit_Player1
@onready var name_input_p2 = $Player2/LineEdit_Player2
@onready var start_button = $Start

func _ready():
	# Set default names when opening the scene
	name_input_p1.text = Global.player1_name
	name_input_p2.text = Global.player2_name
	
	# Connect text changed signals
	name_input_p1.text_changed.connect(_on_name_changed_p1)
	name_input_p2.text_changed.connect(_on_name_changed_p2)

func _on_name_changed_p1(new_text):
	Global.player1_name = new_text.strip_edges()

func _on_name_changed_p2(new_text):
	Global.player2_name = new_text.strip_edges()

func _on_start_button_pressed():
	# Print to check if names are stored correctly
	print("Player 1 Name:", Global.player1_name)
	print("Player 2 Name:", Global.player2_name)

	# Load the game scene (change path to your actual game scene)
	get_tree().change_scene_to_file("res://Scenes/gameScene.tscn")
