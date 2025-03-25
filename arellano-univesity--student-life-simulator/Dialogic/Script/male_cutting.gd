extends CharacterBody2D

const speed = 30
var current_state = IDLE

var dir = Vector2.RIGHT

var is_roaming = true
var is_chatting = false

var player_in_area = false

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready():
	randomize()
	Dialogic.signal_event.connect(DialogicSignal)
  
func _process(delta):
	if player_in_area:
		if Input.is_action_just_pressed("e"):
			run_dialogue("male_cutting")
	
	if current_state == IDLE or current_state == NEW_DIR:
		$AnimatedSprite2D.play("idle")
	elif current_state == MOVE and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.play("w-walk")
		elif dir.x == 1:
			$AnimatedSprite2D.play("e-walk")
	
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.LEFT])
			MOVE:
				move(delta)

func run_dialogue(dialogue_string):
	is_chatting = true
	is_roaming = false
	
	Dialogic.start(dialogue_string)

func DialogicSignal(arg: String):
	if arg == "game_over":
		get_tree().quit()  # Closes the game immediately2

func choose(array):
	array.shuffle()
	return array.front()

func move(delta):
	if !is_chatting:
		position += dir * speed * delta

func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])


func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true


func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
