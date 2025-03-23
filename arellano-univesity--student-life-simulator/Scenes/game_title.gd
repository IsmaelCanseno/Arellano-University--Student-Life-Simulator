extends Label

func _ready():
	position.y = -100  

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)  
	tween.set_ease(Tween.EASE_OUT)  

	tween.tween_property(self, "position:y", 40, 1.5) 
