@tool
class_name AIPaddle
extends BasicPaddle

## How fast the AI reacts to the ball's movement. A lower value makes the AI easier to beat.
@export_range(0.1, 20.0) var reaction_speed: float = 5.0

func _physics_process(delta: float) -> void:
	var balls = get_tree().get_nodes_in_group("balls")
	if balls.is_empty():
		velocity = velocity.lerp(Vector2.ZERO, 0.1)
		move_and_slide()
		return

	var closest_ball = _get_closest_ball(balls)

	if not closest_ball:
		return

	var target_y = closest_ball.global_position.y
	
	var desired_velocity = Vector2(0, (target_y - global_position.y) * reaction_speed)
	
	velocity = velocity.lerp(desired_velocity, 0.2)
	
	move_and_slide()

func _get_closest_ball(balls: Array) -> Node2D:
	var closest_ball = null
	var min_dist_sq = -1
	for ball in balls:
		var dist_sq = global_position.distance_squared_to(ball.global_position)
		if closest_ball == null or dist_sq < min_dist_sq:
			closest_ball = ball
			min_dist_sq = dist_sq
	return closest_ball
