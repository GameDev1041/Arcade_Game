extends Node2D

onready var obstacle = load("res://fire_balls.tscn")
var obsHold = Array()

onready var diamonds = load("res://diamonds.tscn")
onready var paddle = load("res://level_2_paddle.tscn")
var diamondsHold

onready var in_game_ui = load("res://In-Game_UI.tscn")
var in_game_ui_instance
onready var game_over = load("res://GameOver.tscn")
var game_over_instance
var ball_diameter = 110

var score = 0

var pointsArray = Array()
 
var toggle_balls = false

var isGameOver = false
var screen_size = Vector2()
var point11 = Vector2()
var point12 = Vector2()
var point21 = Vector2()
var point22 = Vector2()
var point31 = Vector2()
var point32 = Vector2()
var point41 = Vector2()
var point42 = Vector2()

### keeps track of level ups
### throughout the gameplay
var timeTrack = 0
#### downwards force
var initial_fall_speed = 12
#var initial_fall_speed = 20
#var rotation_sides = 4
### how many balls fall at same time
var setOfPoints = [2,2,2]
var maximum_set_size = 2
var rotation_angles_list = [0,123,222]
## keep track that gap set in starting and followed as it is after
var single_spawn_first = true
var multi_spawn_first = true
var single_spawn = true

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	
	print(points_to_spawn(0))
	randomize()
	## B1 181 ,B2 765,R1 220, R2 665, L1 275, L2 785 
	point11 = Vector2(181,-200)
	point12 = Vector2(765,-200)
	point21 = Vector2(220,-200)
	point22 = Vector2(665,-200)
	point31 = Vector2(275,-200)
	point32 = Vector2(785,-200)
#	point41 = Vector2(230,-200)
#	point42 = Vector2(600,-200)
	pointsArray.insert(0,point11)
	pointsArray.insert(1,point12)
	pointsArray.insert(2,point21)
	pointsArray.insert(3,point22)
	pointsArray.insert(4,point31)
	pointsArray.insert(5,point32)
#	pointsArray.insert(6,point41)
#	pointsArray.insert(7,point42)
	
	in_game_ui_instance = in_game_ui.instance()
	add_child(in_game_ui_instance)
	
	
	game_over_instance = game_over.instance()
	add_child(game_over_instance)
	game_over_instance.get_node("TextureRect").rect_size = screen_size
	game_over_instance.visible = false
	
#	get_node("GameOver/TextureRect").rect_size = screen_size
	for i in range(0,maximum_set_size*2):
		obsHold.insert(i,obstacle.instance())
		add_child(obsHold[i])
		obsHold[i].velocity = 0
		obsHold[i].position = pointsArray[0]
	var point_set_to_spawn = int(rand_range(0,setOfPoints.size()/2))
	
	spawn_objects(points_to_spawn(point_set_to_spawn))
	point_set_to_spawn = int(rand_range(setOfPoints.size()/2,setOfPoints.size()))
	spawn_objects2(points_to_spawn(point_set_to_spawn))
#	get_node("GameOver").visible = false
	
	var tempPaddle = paddle.instance()
	add_child(tempPaddle)
	tempPaddle.rotation_angles_list(rotation_angles_list)
#	tempPaddle.set_rotation(4)# = rotation_sides
	tempPaddle.set_positions(Vector2(screen_size.x/2 - (512/7),screen_size.y/1.5))# = Vector2(screen_size.x/2 - (512/7),screen_size.y/1.5)
	pass

func _process(delta):
	
#	print(get_viewport().get_mouse_position())
	
	if obsHold[0].position.y > screen_size.y/1.3:
		for i in range(0,maximum_set_size):
			obsHold[i].position = Vector2(0,-200)
			obsHold[i].velocity = 0
		print("Yeah")
		### score increase for protect the paddle
		score += 1
#		get_node("In-Game_UI/Hud/HBoxContainer/Score").text = str(score)
		in_game_ui_instance.get_node("Hud/HBoxContainer/Score").text = str(score)
		var point_set_to_spawn = int(rand_range(0,setOfPoints.size()))
		spawn_objects(points_to_spawn(point_set_to_spawn))
	
	if obsHold[maximum_set_size].position.y > screen_size.y/1.3:
		for i in range(maximum_set_size,maximum_set_size*2):
			obsHold[maximum_set_size].position = Vector2(0,-200)
			obsHold[maximum_set_size].velocity = 0
		print("YeahBBB")
		### score increase for protect the paddle
		score += 1
#		get_node("In-Game_UI/Hud/HBoxContainer/Score").text = str(score)
		in_game_ui_instance.get_node("Hud/HBoxContainer/Score").text = str(score)
		var point_set_to_spawn = int(rand_range(0,setOfPoints.size()))
		spawn_objects2(points_to_spawn(point_set_to_spawn))
	if isGameOver:
#		get_node("GameOver").visible = true
		game_over_instance.visible = true
		get_tree().paused = true
#		get_node("GameOver/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Scored").text = str("Scored : ",score)
		game_over_instance.get_node("VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Scored").text = str("Scored : ",score)
	timeTrack += 1
	if timeTrack > 500:
		single_spawn = false
#	print(timeTrack)
	
	pass

## spawn objects according to spawn sets passed
func spawn_objects(spawn_set):
	if(single_spawn):
		var random = int(rand_range(0,spawn_set.size()))
		if spawn_set.size()>1:
			obsHold[0].position = pointsArray[spawn_set[random]] + Vector2(0,-280)
			obsHold[0].velocity = initial_fall_speed
	#### bin case of multiple spawns
	else:
		for i in range(0,maximum_set_size):
			print("ttt<>")
#			obsHold[spawn_set[i]]
			obsHold[i].position = pointsArray[spawn_set[i]] + Vector2(0,-280)
			obsHold[i].velocity = initial_fall_speed

## spawn objects according to spawn sets passed
func spawn_objects2(spawn_set):
	if(single_spawn):
		var random = int(rand_range(0,spawn_set.size()))
		if spawn_set.size()>1:
			if single_spawn_first :
				single_spawn_first = false
				obsHold[maximum_set_size].position = pointsArray[spawn_set[random]] + Vector2(0,-280 - screen_size.y/2)
				obsHold[maximum_set_size].velocity = initial_fall_speed
			else:
				obsHold[maximum_set_size].position = pointsArray[spawn_set[random]] + Vector2(0,-280)
				obsHold[maximum_set_size].velocity = initial_fall_speed
	#### bin case of multiple spawns
	else:
		for i in range(0,maximum_set_size):
			print("Herewew >> ",i,"<>",maximum_set_size)
			if multi_spawn_first :
#				multi_spawn_first = false
				obsHold[i+maximum_set_size].position = pointsArray[spawn_set[i]] + Vector2(0,-280)
#				obsHold[i+maximum_set_size].position = pointsArray[spawn_set[i]] + Vector2(0,-280 - screen_size.y/2)
				obsHold[i+maximum_set_size].velocity = initial_fall_speed
#				obsHold[spawn_set[i]]
			else:
				obsHold[i+maximum_set_size].position = pointsArray[spawn_set[i - maximum_set_size]] + Vector2(0,-280)
				obsHold[i+maximum_set_size].velocity = initial_fall_speed
			print(obsHold[i+maximum_set_size].position)
		multi_spawn_first = false

### returns points to spawn
func points_to_spawn(pointIndex):
	var spawn_points = []
	var total_sum_before = 0
	for i in range(0,pointIndex):
		total_sum_before += setOfPoints[i]
	for i in range(0,setOfPoints[pointIndex]):
		spawn_points.insert(i,total_sum_before + i)
	return spawn_points