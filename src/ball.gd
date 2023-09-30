extends KinematicBody2D

export var SPEED = 300;
export var direction = Vector2();

onready var collider: CollisionShape2D = get_node("CollisionShape2D");


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	direction = direction.normalized();
	
	var collision = self.move_and_collide(direction * SPEED * delta);
	
	if (collision is KinematicCollision2D):
		var collider = (collision.collider as PhysicsBody2D);
		if collider.is_in_group("wall"):
			direction = direction.bounce(collision.normal);
		
		elif collider.is_in_group("paddle"):
			var collider_width = ((collision.collider_shape as CollisionShape2D).shape as RectangleShape2D).extents.x;
			
			# Valor entre -1 y 1.
			var delta_direction = (collision.position.x - collision.collider.position.x) / collider_width;
			direction = Vector2(delta_direction, -direction.y);
			
		
	pass
