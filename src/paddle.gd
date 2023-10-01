extends CharacterBody2D
class_name Paddle

# Publicos
@export var LEFT_ACTION: StringName;
@export var RIGHT_ACTION: StringName;
@export var SLIDE_MULTIPLIER: float;
@export var MAX_SPEED: int;
var score: int = 0;

# Privados
var current_speed = 0;
var current_direction = 0;
@onready var initial_position = position;

func _process(delta):
	if Input.is_action_pressed(LEFT_ACTION):
		move_left();
	elif Input.is_action_pressed(RIGHT_ACTION):
		move_right();
	else:
		idle();
#
	if (current_speed < 0):
		current_speed = 0;
	
	self.set_velocity(Vector2(current_speed * current_direction, 0));
	self.move_and_slide();
	pass

func move_left():
	current_speed = MAX_SPEED;
	current_direction = -1;

func move_right():
	current_speed = MAX_SPEED
	current_direction = 1

func idle():
	current_speed *= SLIDE_MULTIPLIER

func reset_position():
	position = initial_position
	current_speed = 0;
