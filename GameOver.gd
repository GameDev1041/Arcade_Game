extends Control



func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		if get_parent().isGameOver:
			get_tree().paused = false
			get_tree().reload_current_scene()
	pass
	

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if get_parent().isGameOver:
				get_tree().paused = false
				get_tree().reload_current_scene()