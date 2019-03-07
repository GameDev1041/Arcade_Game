extends Control

var screen_size = Vector2()

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	get_node("TextureRect").rect_size = screen_size
	get_node("VBoxContainer/HBoxContainer/Anti_Clock").modulate.a = 0.1
	get_node("VBoxContainer/HBoxContainer/Clock").modulate.a = 0.1
	pass

