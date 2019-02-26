extends Node2D

onready var obstacle = load("res://fire_balls.tscn")
var obsHold = Array()

onready var diamonds = load("res://diamonds.tscn")
onready var paddle = load("res://Paddle.tscn")
var diamondsHold
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
var rotation_sides = 4

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	get_node("TextureRect").rect_size = screen_size
	get_node("GameOver/TextureRect").rect_size = screen_size
	get_node("VBoxContainer/HBoxContainer/anti-clock").modulate.a = 0.1
	get_node("VBoxContainer/HBoxContainer/clock").modulate.a = 0.1
	randomize()
#	get_node("Paddle").position = Vector2(screen_size.x/2 - (512/7),screen_size.y/1.5)
	point11 = Vector2(330,-200)
	point12 = Vector2(871,-200)
	point21 = Vector2(320,-200)
	point22 = Vector2(720,-200)
	point31 = Vector2(120,-200)
	point32 = Vector2(635,-200)
	point41 = Vector2(230,-200)
	point42 = Vector2(600,-200)
	pointsArray.insert(0,point11)
	pointsArray.insert(1,point12)
	pointsArray.insert(2,point21)
	pointsArray.insert(3,point22)
	pointsArray.insert(4,point31)
	pointsArray.insert(5,point32)
	pointsArray.insert(6,point41)
	pointsArray.insert(7,point42)
	
	for i in range(0,4):
		obsHold.insert(i,obstacle.instance())
		add_child(obsHold[i])
#	spawn_balls()
	var randomSet = int(rand_range(0,3))
	randomSet *= 2
	obsHold[2].position = pointsArray[randomSet] + Vector2(-ball_diameter/2,-screen_size.y/2)
	obsHold[3].position = pointsArray[randomSet+1] + Vector2(0,-screen_size.y/2)
	obsHold[3].velocity = 0
	obsHold[0].position = pointsArray[0] + Vector2(-ball_diameter/2,-220)
	obsHold[0].velocity = 0
	obsHold[1].position = pointsArray[1] + Vector2(0,-220)
	obsHold[1].velocity = 0
	get_node("GameOver").visible = false
	
	var tempPaddle = paddle.instance()
	add_child(tempPaddle)
	tempPaddle.set_rotation(4)# = rotation_sides
	tempPaddle.set_positions(Vector2(screen_size.x/2 - (512/7),screen_size.y/1.5))# = Vector2(screen_size.x/2 - (512/7),screen_size.y/1.5)
#	tempPaddle.position = Vector2(screen_size.x/2 - (512/7),screen_size.y/1.5)
#	tempPaddle.rotation_sides = rotation_sides
	
#	diamondsHold = diamonds.instance()
#	diamondsHold.position = Vector2(-500,-100)
#	add_child(diamondsHold)
	pass

func _process(delta):
	if obsHold[0].position.y > screen_size.y/1.3 or obsHold[1].position.y > screen_size.y/1.3:
		### score increase for protect the paddle
		score += 1
		get_node("Hud/HBoxContainer/Score").text = str(score)
#		spawn_balls()
		if timeTrack < 600 :
			spawn_single_balls()
		else:
			spawn_balls()
	
	if obsHold[2].position.y > screen_size.y/1.3 or obsHold[3].position.y > screen_size.y/1.3:
		### score increase for protect the paddle
		score += 1
		get_node("Hud/HBoxContainer/Score").text = str(score)
#		spawn_balls2()
		if timeTrack < 600:
			spawn_single_balls2()
		else:
			spawn_balls2()
	if isGameOver:
		get_node("GameOver").visible = true
		get_tree().paused = true
		get_node("GameOver/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Scored").text = str("Scored : ",score)
	timeTrack += 1
#	print(timeTrack)
	
	pass

func spawn_balls():
	var randomSet = int(rand_range(0,4))
	randomSet *= 2
	obsHold[0].position = pointsArray[randomSet] + Vector2(-ball_diameter/2,-280)
	obsHold[1].position = pointsArray[randomSet+1] + Vector2(0,-280)

func spawn_balls2():
	var randomSet = int(rand_range(0,4))
	randomSet *= 2
	obsHold[2].position = pointsArray[randomSet] + Vector2(-ball_diameter/2,-280)
	obsHold[3].position = pointsArray[randomSet+1] + Vector2(0,-280)


### One ball at a time 
func spawn_single_balls():
	randomize()
	var randomSet = int(rand_range(0,4))
	randomSet *= 2
	
	var switch_sides = int(rand_range(0,2))
	obsHold[1].velocity = initial_fall_speed
	obsHold[0].velocity = initial_fall_speed
	if switch_sides == 0:
		obsHold[0].position = pointsArray[randomSet] + Vector2(-ball_diameter/2,-280)
		obsHold[1].position = Vector2(-700,0) + Vector2(0,-280)
	else:
		obsHold[0].position = Vector2(-700,0) + Vector2(-ball_diameter/2,-280)
		obsHold[1].position = pointsArray[randomSet+1] + Vector2(0,-280)

func spawn_single_balls2():
	var randomSet = int(rand_range(0,4))
	randomSet *= 2
	
	var switch_sides = int(rand_range(2,4))
	obsHold[2].velocity = initial_fall_speed
	obsHold[3].velocity = initial_fall_speed
	if switch_sides == 0:
		obsHold[2].position = pointsArray[randomSet] + Vector2(-ball_diameter/2,-280)
		obsHold[3].position = Vector2(-700,0) + Vector2(0,-280)
	else:
		obsHold[2].position = Vector2(-700,0) + Vector2(-ball_diameter/2,-280)
		obsHold[3].position = pointsArray[randomSet+1] + Vector2(0,-280)