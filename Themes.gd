extends Node2D

var pivot_location = 0
var rotate_each = 0

var adjust_angle = 45
var rotate_right = false
var rotate_left = false
var rotate_play = false
var rotate_play_amount = 0
var rotate_speed = 5
var total_rotation = 0


func _ready():
	pivot_location = get_viewport().get_visible_rect().size.x/5
	$First.offset = Vector2(0,-pivot_location)
	$First.rotation = deg2rad(0)
	$Second.offset = Vector2(0,-pivot_location)
	$Second.rotation = deg2rad(90)
	$Third.offset = Vector2(0,-pivot_location)
	$Third.rotation = deg2rad(180)
	$Fourth.offset = Vector2(0,-pivot_location)
	$Fourth.rotation = deg2rad(270)
	
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		if not rotate_left :
			rotate_left = true
			rotate_play = true
#			get_parent().item_selected += 1
		print("Left is clicked")
	if Input.is_action_just_pressed("ui_right"):
		if not rotate_right:
			rotate_right = true
			rotate_play = true
#			get_parent().item_selected -= 1
		print("Right is clicked")
#	if rotate_each>359:
#		rotate_each = 0
#	else:
#		rotate_each += 1
		
#	print(abs(rotate_each))
	if rotate_each > 89 or rotate_each < -89:
		total_rotation = total_rotation+rotate_each
		rotate_each = 0
		rotate_right = false
		rotate_left = false
	
	if rotate_play_amount > 119 or rotate_play_amount <-119:
		rotate_play_amount = 0
		rotate_play = false
	
	if rotate_right and not rotate_left:
		rotate_each += rotate_speed
	
	elif rotate_left:
		rotate_each -= rotate_speed
	
	if rotate_play:
		if rotate_left:
			rotate_play_amount -= rotate_speed + int(rotate_speed * 0.5)
		if rotate_right:
			rotate_play_amount += rotate_speed + int(rotate_speed * 0.5)
	
	
	$First.rotation = deg2rad(0+total_rotation+rotate_each)
	$Second.rotation = deg2rad(90+total_rotation+rotate_each)
	$Third.rotation = deg2rad(180+total_rotation+rotate_each)
	$Fourth.rotation = deg2rad(270+total_rotation+rotate_each)
	$play_button.rotation = deg2rad((-rotate_play_amount))
	pass
