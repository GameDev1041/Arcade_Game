extends Node2D

func _ready():
	pass

func _process(delta):
	position.y += 8
	rotate(deg2rad(3))
	pass

func _on_Area2D_area_entered(area):
	print(area.get_parent().name,"<> collided")
	pass # replace with function body