extends Node2D

@onready var player1 := $Player1Paddle as Paddle;
@onready var player2 := $Player2Paddle as Paddle;
@onready var ball:= $Ball as Ball;
@onready var player1_scoreboard: Label = $Camera2D/CanvasLayer/UI/VBoxContainer/Player1;
@onready var player2_scoreboard: Label = $Camera2D/CanvasLayer/UI/VBoxContainer/Player2;
@onready var shot_ball_timer: Timer = $ShotBallTimer;
@onready var restart_game_timer: Timer = $RestartGameTimer;

@export var MAX_SCORE = 10;

func _ready():
	$Player2GoalArea.body_exited.connect(func(body: Node2D): score_goal(player1));
	$Player1GoalArea.body_exited.connect(func(body: Node2D): score_goal(player2));
	
	shot_ball_timer.timeout.connect(shot_ball);
	restart_game_timer.timeout.connect(restart_game);
	
	restart_game()

func shot_ball():
	ball.shot()

func score_goal(paddle: Paddle):
	paddle.score += 1;
	player1_scoreboard.text = str(player1.score);
	player2_scoreboard.text = str(player2.score);
	
	if paddle.score >= MAX_SCORE:
		end_game(paddle);
		return;
	
	player1.reset_position();
	player2.reset_position();
	ball.reset_position();
	shot_ball_timer.start();

func end_game(paddle: Paddle):
	if (paddle == player1):
		player1_scoreboard.add_theme_color_override("font_color", Color.GREEN_YELLOW);
		player2_scoreboard.add_theme_color_override("font_color", Color.ORANGE_RED);
	elif (paddle == player2):
		player2_scoreboard.add_theme_color_override("font_color", Color.GREEN_YELLOW);
		player1_scoreboard.add_theme_color_override("font_color", Color.ORANGE_RED);
	
	restart_game_timer.start();
	
func restart_game():
	player1.score = 0;
	player2.score = 0;
	
	player1_scoreboard.add_theme_color_override("font_color", Color.WHITE);
	player2_scoreboard.add_theme_color_override("font_color", Color.WHITE);
	player1_scoreboard.text = str(player1.score);
	player2_scoreboard.text = str(player2.score);
	player1.reset_position();
	player2.reset_position();
	ball.reset_position();

	shot_ball_timer.start();
