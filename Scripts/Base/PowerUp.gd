extends Area2D

class_name PowerUp

func power_up(body, function):
	if(body.name == "LZer"):
		body.call(function)
