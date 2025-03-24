extends Control

@onready var name_input_p1 = $VBoxContainer/HBoxContainer/Character1/LineEdit_Player1
@onready var name_input_p2 = $VBoxContainer/HBoxContainer/Character2/LineEdit_Player2
@onready var start_button = $Start
@onready var character_selection_box = $VBoxContainer/HBoxContainer

func _ready():
	# Set default names when opening the scene
	name_input_p1.text = Global.player1_name
	name_input_p2.text = Global.player2_name

	# Ensure text changes update global variables
	name_input_p1.text_changed.connect(_on_name_changed_p1)
	name_input_p2.text_changed.connect(_on_name_changed_p2)
func _on_name_changed_p1(new_text):
	Global.player1_name = new_text.strip_edges()

func _on_name_changed_p2(new_text):
	Global.player2_name = new_text.strip_edges()

func _input(event):
	if event is InputEventMouseButton && event.button_index == 1 && event.is_pressed():
		var charNode = _get_char_node()
		
		if charNode: _set_char_selected(charNode)
		
func _get_char_node():
	var mousePos = get_viewport().get_mouse_position()
	
	for node in character_selection_box.get_children():
		if node.get_global_rect().has_point(mousePos):
			return node

func _set_char_selected(charNode):
	Global.player1_name = charNode.characterPath  # Ensure correct variable usage
	
	for node in character_selection_box.get_children():
		var isSelected = charNode == node
		node.set_selected(isSelected)

func _on_start_pressed()-> void:
	# Print to check if names are stored correctly
	print("Player 1 Name:", Global.player1_name)
	print("Player 2 Name:", Global.player2_name)

	# Load the game scene (change path to your actual game scene)
	get_tree().change_scene_to_file("res://Scenes/house.tscn")
	
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
