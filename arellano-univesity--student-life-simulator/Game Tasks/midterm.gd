extends Control

@onready var QuestionItems = $VBoxContainer/QuestionTexts
@onready var AnswersList = $AnswersList
@onready var RestartButton = $RestartButton
@onready var WrongNumber = $WrongNumber
@onready var ScoreNumber = $ScoreNumber
@onready var CorrectAnswer = $CorrectAnswer
@onready var OKButton = $OK
@onready var Congratulation = $Correct
@onready var RewardButton = $RewardButton  # Make sure you add a Done/Exit button in the scene

var items: Array
var item: Dictionary
var index_item: int = 0
var wrong: int = 0
var correct: float = 0
var updatedCorrectAnswerIndex: int

func _ready():
	items = read_json_file("res://Questions/midterm.json")
	items.shuffle()
	show_questions()
	displayScore()

func displayScore():
	WrongNumber.text = "Wrong: " + str(wrong)
	ScoreNumber.text = "Score: " + str(correct)+"/"+str(items.size())

func show_questions():
	CorrectAnswer.hide()
	OKButton.hide()
	Congratulation.hide()
	AnswersList.show()
	ScoreNumber.show()
	RestartButton.hide()
	AnswersList.clear()
	WrongNumber.show()
	RewardButton.hide()  # Hide Done button while answering questions
	item = items[index_item]
	QuestionItems.text = item.question
	var options = item.options
	var correctAnswer = item.options[item.correctOptionIndex]
	options.shuffle()
	for option in options:
		if option == correctAnswer:
			updatedCorrectAnswerIndex = options.find(option,0)
	print(options)
	for option in options:
		AnswersList.add_item(option)

func show_result():
	displayScore()
	AnswersList.hide()
	Congratulation.hide()
	CorrectAnswer.hide()
	OKButton.hide()
	RestartButton.show()
	WrongNumber.show()
	ScoreNumber.show()
	RewardButton.show()  # Show the Done button after the quiz ends
	
	var percentage = round(correct/items.size()*100)
	var greet
	if percentage >= 60:
		greet = "Very good!"
	else:
		greet = "Too bad!"
	QuestionItems.text = "{greet} You're correct {percentage} %".format({"greet": greet, "percentage": percentage})

func refresh_scene():
	if index_item >= items.size():
		show_result()
	else:
		show_questions()
		displayScore()

func read_json_file(filename):
	var json_as_text = FileAccess.get_file_as_string(filename)
	var json_as_dict = JSON.parse_string(json_as_text)
	return json_as_dict

func show_correct_answer():
	AnswersList.hide()
	ScoreNumber.show()
	RestartButton.hide()
	CorrectAnswer.show()
	OKButton.show()
	Congratulation.hide()
	WrongNumber.show()
	item = items[index_item]
	CorrectAnswer.text = "The correct answer is: " + item.options[updatedCorrectAnswerIndex]

func show_congratulations():
	AnswersList.hide()
	ScoreNumber.show()
	RestartButton.hide()
	CorrectAnswer.show()
	OKButton.hide()
	Congratulation.show()
	WrongNumber.show()
	item = items[index_item]
	CorrectAnswer.text = "The correct answer is: " + item.options[updatedCorrectAnswerIndex]

func _on_ok_pressed():
	index_item +=1
	refresh_scene()

func _on_correct_pressed():
	index_item +=1
	refresh_scene()

func _on_answers_list_item_selected(index):
	if index == updatedCorrectAnswerIndex:
		correct +=1
		show_congratulations()
	else:
		wrong +=1
		show_correct_answer()
		
func _on_restart_button_pressed():
	get_tree().reload_current_scene()

func _on_reward_button_pressed() -> void:
	get_tree().change_scene_to_file("res://burger batch/midterm burger.tscn")
