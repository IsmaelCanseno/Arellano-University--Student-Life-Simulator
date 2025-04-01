extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  SilentWolf.configure({
	"api_key": "JVb13IpKzaaUT3PK5xMvx2vccI6GJNSj95n35USf",
	"game_id": "ausls",
	"log_level": 1
  })

  SilentWolf.configure_scores({
	"open_scene_on_close": "res://Scenes/leaderboards.tscn"
  })
