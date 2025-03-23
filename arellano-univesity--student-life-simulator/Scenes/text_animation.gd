extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label

func _ready():
	area_2d.body_entered.connect(_on_body_entered)
	label.visible_ratio = 0 # Initially hide the label text

func _on_body_entered(body: Node2D):
	if body is CharacterBody2D: # Check if the entering body is a CharacterBody2D
		area_2d.body_entered.disconnect(_on_body_entered) # Disconnect to prevent multiple triggers
		animation_player.play("show_text") # Play the text animation
		label.visible_ratio = 1 # Show the entire label text.

	# Optional: If you want to hide the text after a delay, use a Timer or AnimationPlayer signal
	# Example using AnimationPlayer signal:
	animation_player.animation_finished.connect(_hide_text)

func _hide_text(anim_name):
	if anim_name == "show_text":
		label.visible_ratio = 0
		animation_player.animation_finished.disconnect(_hide_text) # Disconnect the signal
