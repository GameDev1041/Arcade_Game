extends Node2D

var screen_size = Vector2()

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
#		get_node("Sprite").set_rotation(deg2rad(90))
		get_node("Sprite").rotation += deg2rad(90)
	
	if Input.is_action_just_pressed("ui_left"):
#		get_node("Sprite").set_rotation(deg2rad(-90))
		get_node("Sprite").rotation -= deg2rad(90)
	pass 

func _input(event):
	if event is InputEventScreenTouch:
		var touchPos = get_viewport().get_mouse_position()
		if event.pressed:
			if touchPos.x < (screen_size.x/2):
				get_node("Sprite").rotation -= deg2rad(90)
				get_parent().get_node("VBoxContainer/HBoxContainer/anti-clock").modulate.a = 0.4
			else:
				get_node("Sprite").rotation += deg2rad(90)
				get_parent().get_node("VBoxContainer/HBoxContainer/clock").modulate.a = 0.4
		if not event.pressed:
			print("Mumbai")
			get_parent().get_node("VBoxContainer/HBoxContainer/anti-clock").modulate.a = 0.1
			get_parent().get_node("VBoxContainer/HBoxContainer/clock").modulate.a = 0.1