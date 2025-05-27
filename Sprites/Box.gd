extends KinematicBody2D
class_name boxClass
export var pushPower = 40
func push(vec):
	move_and_slide(vec*pushPower, Vector2())
