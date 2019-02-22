extends Node2D

var item_selected = 0
var screen_size = Vector2()
func _ready():
	screen_size = get_viewport().get_visible_rect().size
	get_node("ColorRect").rect_size = screen_size
	pass

func _on_Play_TextureButton_pressed():
#	print("debug play")
	get_tree().change_scene_to(load("res://Manager.tscn"))
	pass # replace with function body

#func _process(delta):
#	print(item_selected)
func _on_Left_TextureButton_pressed():
#	print("debug left")
	get_node("Themes").rotate_left = true
	get_node("Themes").rotate_play = true
	item_selected += 1
	pass # replace with function body


func _on_Right_TextureButton_pressed():
#	print("debug right")
	get_node("Themes").rotate_right = true
	get_node("Themes").rotate_play = true
	item_selected -= 1
	pass # replace with function body
