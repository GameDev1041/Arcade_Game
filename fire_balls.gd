extends Node2D
### downwards movements

var velocity = 10
func _ready():
	pass

func _process(delta):
	
	### reached to the end of everything
#	if position.y > 700:
#		position.y = -200
#	else:
	position.y += velocity
	pass


func _on_Area2D_area_entered(area):
	if area.get_parent().get_parent().name == str("Paddle"):
		get_parent().isGameOver = true
	print("Karaoge print<>",area.get_parent().get_parent().name)
	pass # replace with function body