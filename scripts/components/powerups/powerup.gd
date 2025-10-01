class_name PowerUp
extends Area2D

# This property will be overridden by specific power-up scripts
var type = "base"

func _enter_tree():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body.is_in_group("paddles") and body.has_method("apply_powerup"):
		body.apply_powerup(self)
		queue_free()