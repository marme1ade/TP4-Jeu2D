extends Node2D

var _lives = 3
var _current_level = 0
var _level_instance = null
var _score = 0 # TODO Afficher le score à l'écran
var _game_has_ended = false

func _ready():
	_load_level()

func _load_level(level = 0):
	if level < Constants.MAX_LEVEL:
		if _game_has_ended:
			_reset_game_stats()

		var new_level = Constants.levels[level].instance()
		new_level.connect("player_hit", self, "_on_Player_hit")
		new_level.connect("player_bonus", self, "_on_Player_bonus")
		new_level.connect("next_level", self, "_on_Next_level")
		new_level.connect("enemy_killed", self, "_on_Enemy_killed")

		add_child(new_level)
		if _level_instance != null:
			_level_instance.queue_free()
		_level_instance = new_level
	else: # Fin du jeu
		_end_game() 

func _load_next_level():
	_current_level += 1
	_load_level(_current_level)

func _update_lives(ajustement):
	_lives += ajustement
	if _lives > 3: _lives = 3

	$CanvasLayer/Lives.set_frame(_lives)

	if _lives == 0:
		_level_instance.end_level()
		_end_game(true)

# TODO
# Afficher un menu qui donne 3 options et qui affiche le score final : 
# - Rejouer le niveau (si show_restart_level_button) -> _load_level(_current_level)
# - Recommencer le jeu, -> _load_level()
# - Quitter le jeu -> get_tree().quit()
func _end_game(show_restart_level_button = false):
	_game_has_ended = true
	print("Score: ", _score)

func _reset_game_stats():
	_update_lives(3)
	_score = 0
	_game_has_ended = false


func _on_Player_hit(enemy_type):
	if enemy_type != Constants.Enemy.dog2:
		_update_lives(-1)

func _on_Player_bonus(bonus, qty):
	match bonus:
		Constants.Bonus.live:
			_update_lives(qty)
		_:
			pass

func _on_Next_level():
	_load_next_level()

func _on_Enemy_killed():
	_score += 1
	


