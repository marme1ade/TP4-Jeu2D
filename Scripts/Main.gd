extends Node2D

var _lives = 3
var _current_level = 0
var _level_instance

func _ready():
	_load_level()

func _load_level(level = 0):
	if level < Constants.MAX_LEVEL:
		_level_instance = Constants.levels[level].instance()
		_level_instance.connect("player_hit", self, "_on_Player_hit")
		_level_instance.connect("player_bonus", self, "_on_Player_bonus")
		add_child(_level_instance)
	else:
		pass # Fin du jeu, afficher le score

func _load_next_level():
	_current_level += 1
	_load_level(_current_level)

func _update_lives(ajustement):
	_lives += ajustement
	if _lives > 3: _lives = 3

	$CanvasLayer/Lives.set_frame(_lives)

	if _lives == 0:
		_level_instance.end_level()


func _on_Player_hit(enemy_type):
	if enemy_type != Constants.Enemy.dog2:
		_update_lives(-1)

func _on_Player_bonus(bonus, qty):
	match bonus:
		Constants.Bonus.live:
			_update_lives(qty)
		_:
			pass
	


