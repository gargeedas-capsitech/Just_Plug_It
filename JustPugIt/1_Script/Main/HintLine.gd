extends Node2D
class_name HintLine

@onready var line = $Line2D

# var path_points :Array[Vector2] = []

func hintDrow(path_points):
	# if path_points.size()>0:
	print(path_points[0].x)
	line.points = path_points
