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
	
func _process(delta):
	if player_in_area:
		if Input.is_action_just_pressed("e"):
			run_rando_dialogue()
	
	if current_state == IDLE or current_state == NEW_DIR:
		$AnimatedSprite2D.play("idle")
	elif current_state == MOVE and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.play("w-walk")
		elif dir.x == 1:
			$AnimatedSprite2D.play("e-walk")
		elif dir.y == -1:
			$AnimatedSprite2D.play("n-walk")
		elif dir.y == 1:
			$AnimatedSprite2D.play("s-walk")

	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
				current_state = MOVE
			MOVE:
				move(delta)

func run_rando_dialogue():
	Dialogic.timeline_ended.connect(ended_dialogue)
	is_chatting = true
	is_roaming = false
	
	Dialogic.start("prof_prelim")

func ended_dialogue():
	Dialogic.timeline_ended.disconnect(ended_dialogue)  # Removed parentheses
	is_chatting = false
	is_roaming = true

func choose(array):
	array.shuffle()
	return array.front()

func move(delta):
	if !is_chatting:
		velocity = dir * speed
		move_and_slide()

func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])

func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true

func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
