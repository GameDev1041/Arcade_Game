extends Node2D

var item_selected = 0
var screen_size = Vector2()
var total_levels = 0
var levels_list = []
func _ready():
	screen_size = get_viewport().get_visible_rect().size
	get_node("ColorRect").rect_size = screen_size
	total_levels = get_node("Themes").get_child_count()-1
	
	#### insert  levels here and update icon in Themes
	for i in range(0,total_levels):
		levels_list.append("res://Manager.tscn")
	pass

func _on_Play_TextureButton_pressed():
#	print("debug play")
	get_tree().change_scene_to(load(levels_list[item_selected]))
	
	pass # replace with function body

#func _process(delta):
#	print(item_selected)
func _on_Left_TextureButton_pressed():
#	print("debug left")
	get_node("Themes").rotate_left = true
	get_node("Themes").rotate_play = true
	if(item_selected >= total_levels-1):
		item_selected = 0
	else:
		item_selected += 1
	print(item_selected)
	pass # replace with function body


func _on_Right_TextureButton_pressed():
#	print("debug right")
	get_node("Themes").rotate_right = true
	get_node("Themes").rotate_play = true
	if(item_selected <= 0):
		item_selected = total_levels-1
	else:
		item_selected -= 1
	print(item_selected)
	pass # replace with function body
