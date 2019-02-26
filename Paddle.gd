extends Node2D

var screen_size = Vector2()
var rotation_sides
func _ready():
	screen_size = get_viewport().get_visible_rect().size
	set_process(false)
	get_tree().paused = true
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
#		get_node("Sprite").set_rotation(deg2rad(90))
		get_node("Sprite").rotation += deg2rad(360/rotation_sides)
		print(rotation_sides)
	
	if Input.is_action_just_pressed("ui_left"):
#		get_node("Sprite").set_rotation(deg2rad(-90))
		get_node("Sprite").rotation -= deg2rad(360/rotation_sides)
	pass 

func _input(event):
	if event is InputEventScreenTouch:
		var touchPos = get_viewport().get_mouse_position()
		if event.pressed:
			if touchPos.x < (screen_size.x/2):
				get_node("Sprite").rotation -= deg2rad(360/rotation_sides)
				get_parent().get_node("VBoxContainer/HBoxContainer/anti-clock").modulate.a = 0.4
			else:
				get_node("Sprite").rotation += deg2rad(360/rotation_sides)
				get_parent().get_node("VBoxContainer/HBoxContainer/clock").modulate.a = 0.4
		if not event.pressed:
			print("Mumbai")
			get_parent().get_node("VBoxContainer/HBoxContainer/anti-clock").modulate.a = 0.1
			get_parent().get_node("VBoxContainer/HBoxContainer/clock").modulate.a = 0.1


func set_rotation(what_rotations):
	rotation_sides = what_rotations

func set_positions(what_positions):
	position = what_positions
	get_tree().paused = false
	set_process(false)