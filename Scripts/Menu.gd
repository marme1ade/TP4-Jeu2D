extends Node

var game_scene_path = "res://Scenes/Main.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Quitter_Btn_pressed():
	get_tree().quit()

func _on_Start_Btn_pressed():
	get_tree().change_scene(game_scene_path)
