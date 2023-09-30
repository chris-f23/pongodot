extends KinematicBody2D

const SLIDE_MULTIPLIER = 0.8;
const MAX_SPEED = 300;
var current_speed = 0;
var current_direction = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if (Input.is_action_pressed("ui_left")):
		current_speed = MAX_SPEED
		current_direction = -1
	elif (Input.is_action_pressed("ui_right")):
		current_speed = MAX_SPEED
		current_direction = 1
	else:
		current_speed *= SLIDE_MULTIPLIER
		
	if (current_speed < 0):
		current_speed = 0
	
	self.move_and_slide(Vector2(current_speed * current_direction, 0))
	pass
