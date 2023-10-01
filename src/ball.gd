extends CharacterBody2D
class_name Ball

# Publicos
@export var MIN_SPEED: int;
@export var MAX_SPEED: int;
@export var SPEED_INCREMENT: int;
@export var Y_RESET_OFFSET: int;

# Privados
var current_direction = Vector2();
var current_speed = 0;
@onready var initial_position = position;

func _physics_process(delta):
	current_direction = current_direction.normalized();
	
	var collision = move_and_collide(current_direction * current_speed * delta);
	if (collision is KinematicCollision2D):		
		var collider = collision.get_collider() as PhysicsBody2D;
		if collider.is_in_group("wall"):
			current_direction = current_direction.bounce(collision.get_normal());
		
		elif collider.is_in_group("paddle"):
			var collider_width = ((collision.get_collider_shape() as CollisionShape2D).shape as RectangleShape2D).size.x;
			
			# Valor entre -1 y 1.
			var delta_direction = (collision.get_position().x - collider.position.x) / collider_width;
			current_direction = Vector2(delta_direction, -current_direction.y);
			
			if current_speed + SPEED_INCREMENT <= MAX_SPEED:
				current_speed += SPEED_INCREMENT;
		
	pass

func reset_position():
	current_speed = 0;
	var y_direction = -1 if randi_range(0, 1) == 0 else 1;
	
	if position.y > initial_position.y:
		y_direction = -1;
	elif position.y < initial_position.y:
		y_direction = 1;
	
	current_direction = Vector2(randf_range(-0.5, 0.5), y_direction);
	position = Vector2(initial_position.x, initial_position.y + (Y_RESET_OFFSET * -y_direction));
	
func shot():
	current_speed = MIN_SPEED;
