extends Node

var stumb_scene=preload("res://scenes/stumb.tscn")
var rock_scene=preload("res://scenes/rock.tscn")
var barrel_scene=preload("res://scenes/barrel.tscn")
var bird_scene=preload("res://scenes/bird.tscn")
var obstacle_types:=[stumb_scene, rock_scene,barrel_scene]
var obstacles:Array
var bird_heights:=[200,390]

const DINO_START_POS := Vector2i(150,455)
const CAM_START_POS:=Vector2i(576,324)
var speed:float
var score :int
const SCORE_MODIFIER: int =10
const START_SPEED:float=10
const MAX_SPEED: int=25
const SPEED_MODIFIER : int=5000
var screen_size : Vector2i
var ground_height: int
var game_running:bool
var last_obs

func _ready() -> void:
	screen_size=get_window().size
	new_game()

func new_game():
	score=0
	show_score()
	game_running=false
	$dino.position=DINO_START_POS
	$dino.velocity=Vector2i(0,0)
	$Camera2D.position=CAM_START_POS
	$ground.position=Vector2i(0,0)
	$hud.get_node("start").show()
	
func _physics_process(delta: float) -> void:
	if game_running:
		speed=START_SPEED+score/SPEED_MODIFIER
		if speed >MAX_SPEED:
			speed=MAX_SPEED
		
		generate_obs()
		$dino.position.x +=speed
		$Camera2D.position.x +=speed
		score+=speed
		show_score()
		if $Camera2D.position.x - $ground.position.x > screen_size.x * 1.5:
			$ground.position.x += screen_size.x
	else:
		if Input.is_action_pressed("ui_accept"):
			game_running=true
			$hud.get_node("start").hide()
			
func generate_obs():
	if obstacles.is_empty():
		var obs_type=obstacle_types[randi() % obstacle_types.size()]
		var obs
		obs=obs_type.instantiate()
		var obs_height = obs.get_node("Sprite2D").texture.get_height()
		var obs_scale = obs.get_node("Sprite2D").scale
		last_obs= obs
		add_child(obs)
		obstacles.append(obs)
func show_score():
	$hud.get_node("score").text="SCORE: "+ str(score/SCORE_MODIFIER)
