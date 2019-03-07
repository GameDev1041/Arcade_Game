extends Node2D

var screen_size = Vector2()
var rotation_sides
var rotation_angle_list = []
var current_rotation_index = 0
func _ready():
	screen_size = get_viewport().get_visible_rect().size
	set_process(false)
	get_tree().paused = true
	pass

#func _process(delta):
#	if Input.is_action_just_pressed("ui_right"):
##		get_node("Sprite").set_rotation(deg2rad(90))
#		get_node("Sprite").rotation += deg2rad(rotation_angle_list[current_rotation_index])#deg2rad(360/rotation_sides)
#		change_index(1)
##		print(rotation_sides)
#
#	if Input.is_action_just_pressed("ui_left"):
##		get_node("Sprite").set_rotation(deg2rad(-90))
#		get_node("Sprite").rotation -= deg2rad(rotation_angle_list[current_rotation_index])#deg2rad(360/rotation_sides)
#		change_index(-1)
#	pass 

func _input(event):
	if event is InputEventScreenTouch:
		var touchPos = get_viewport().get_mouse_position()
		if event.pressed:
			if touchPos.x < (screen_size.x/2):
				if current_rotation_index>0:
					current_rotation_index -= 1
				else:
					current_rotation_index = rotation_angle_list.size()-1
				print(current_rotation_index,"<f>")
				get_node("Sprite").rotation = deg2rad(rotation_angle_list[current_rotation_index])#deg2rad(360/rotation_sides)
				get_parent().get_node("In-Game_UI/VBoxContainer/HBoxContainer/Anti_Clock").modulate.a = 0.4
#				get_parent().get_node("VBoxContainer/HBoxContainer/anti-clock").modulate.a = 0.4
			else:
				
				if current_rotation_index<rotation_angle_list.size()-1:
					current_rotation_index += 1
				else:
					current_rotation_index = 0
				get_node("Sprite").rotation = deg2rad(rotation_angle_list[current_rotation_index])#deg2rad(360/rotation_sides)
#				get_parent().get_node("VBoxContainer/HBoxContainer/clock").modulate.a = 0.4
				get_parent().get_node("In-Game_UI/VBoxContainer/HBoxContainer/Clock").modulate.a = 0.4
#				print(current_rotation_index)
		if not event.pressed:
#			print("Mumbai")
#			get_parent().get_node("VBoxContainer/HBoxContainer/anti-clock").modulate.a = 0.1
			get_parent().get_node("In-Game_UI/VBoxContainer/HBoxContainer/Anti_Clock").modulate.a = 0.1
#			get_parent().get_node("VBoxContainer/HBoxContainer/clock").modulate.a = 0.1
			get_parent().get_node("In-Game_UI/VBoxContainer/HBoxContainer/Clock").modulate.a = 0.1


func set_rotation(what_rotations):
	rotation_sides = what_rotations

#func change_index(index):
#	if current_rotation_index<0:
#		current_rotation_index = rotation_angle_list.size()
#	elif current_rotation_index>rotation_angle_list.size()-1:
#		current_rotation_index = 0
#	else:
#		current_rotation_index += index
#	print(rotation_angle_list,index)

func rotation_angles_list(angles_list):
	rotation_angle_list = angles_list

func set_positions(what_positions):
	position = what_positions
	get_tree().paused = false
	set_process(false)