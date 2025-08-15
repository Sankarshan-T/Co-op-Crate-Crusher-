extends Area3D

var player1_in_range = false
var player2_in_range = false


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player1"):
		player1_in_range = true
	if body.is_in_group("player2"):
		player2_in_range = true
	if player1_in_range and player2_in_range:
		if StageManager.current_lev == 0:
			StageManager.change_stage(1)
		elif StageManager.current_lev == 1:
			StageManager.change_stage(2)
		elif StageManager.current_lev == 2:
			StageManager.change_stage(-1)
			
func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player1"):
		player1_in_range = false
	if body.is_in_group("player2"):
		player2_in_range = false
