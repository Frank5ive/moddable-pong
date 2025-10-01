extends Node

## Emitted from [HUD] when it is added to the scene
@warning_ignore("unused_signal")
signal hud_added

signal score_changed
signal goal_scored(ball: Node2D, player: Player)

enum Player { LEFT, RIGHT, BOTH }

## Stores the score for each player.
var score = {
	Player.LEFT: 0,
	Player.RIGHT: 0,
}

var hit_counter: int = 0
const HITS_FOR_SPEED_INCREASE: int = 5
const SPEED_INCREASE_FACTOR: float = 1.1

func register_hit() -> bool:
	hit_counter += 1
	if hit_counter >= HITS_FOR_SPEED_INCREASE:
		hit_counter = 0
		return true
	return false

func score_goal(ball: Node2D, player: Player):
	goal_scored.emit(ball, player)


func add_score(player: Player, value: int):
	if player == Player.BOTH:
		score[Player.RIGHT] += value
		score[Player.LEFT] += value
	else:
		score[player] += value
	score_changed.emit()
