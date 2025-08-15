extends CanvasLayer


const  LEV0 = preload("res://Scenes/Levels/Level 0.tscn")
const  LEV1 = preload("res://Scenes/Levels/Level 1.tscn")
const  END = preload("res://Scenes/Globals/end_screen.tscn")

var current_lev = 0
@onready var anim: AnimationPlayer = $AnimationPlayer

func change_stage(level: int):
	get_tree().paused = true
	anim.play("Trans_in")
	await anim.animation_finished
	
	
	if level == 1 and current_lev == 0:
			get_tree().change_scene_to_file("res://Scenes/Levels/Level 1.tscn")
			current_lev += 1
	if level == 2 and current_lev == 1:
			get_tree().change_scene_to_file("res://Scenes/Levels/Level 2.tscn")
			current_lev += 1
	if level == -1 and current_lev == 2:
			get_tree().change_scene_to_file("res://Scenes/Globals/end_screen.tscn")
			current_lev = 0
		
	await get_tree().process_frame
	anim.play("Trans_out")
	await anim.animation_finished
	get_tree().paused = false
