extends Node2D

@onready var player1 := $Player1Paddle as Paddle;
@onready var player2 := $Player2Paddle as Paddle;
@onready var ball:= $Ball as Ball;
@onready var player1_scoreboard: Label = $Camera2D/CanvasLayer/UI/VBoxContainer/Player1;
@onready var player2_scoreboard: Label = $Camera2D/CanvasLayer/UI/VBoxContainer/Player2;
@onready var timer: Timer = $Timer;

func _ready():
	$Player2GoalArea.body_exited.connect(func(body: Node2D): score_goal(player1));
	$Player1GoalArea.body_exited.connect(func(body: Node2D): score_goal(player2));
	
	timer.timeout.connect(after_score_goal);
	ball.reset_position();
	timer.start();

func after_score_goal():
	ball.shot()

func score_goal(paddle: Paddle):
	paddle.score += 1;
	player1.reset_position();
	player2.reset_position();
	ball.reset_position();
	
	player1_scoreboard.text = str(player1.score);
	player2_scoreboard.text = str(player2.score);
	
	timer.start();
	pass

#func _on_score_updated():
#	$Player1Paddle.
