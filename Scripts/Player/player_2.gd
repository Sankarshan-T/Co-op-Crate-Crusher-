extends CharacterBody3D


const SPEED = 7.0
const JUMP_VELOCITY = 20

@onready var anim_tree: AnimationTree = $AnimationTree
@onready var anim_state: AnimationNodeStateMachinePlayback = anim_tree.get("parameters/playback")

var state:String = "Idle"

func _ready() -> void:
	anim_state.travel(state)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += -70 * delta

	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("res://Scenes/Globals/main_screen.tscn")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_action_strength("right2") - Input.get_action_strength("left2")
	
	velocity.x = input_dir* SPEED
	move_and_slide()
	
	if input_dir != 0:
		rotation.y = PI/2 if input_dir > 0 else -PI/2
	
	var new_state = state
	if Input.is_action_just_pressed("jump2") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	elif not is_on_floor():
		new_state = "Jump Start"
	elif is_on_floor():
		if state == "Jump Start":
			new_state = "Jump Land"
		elif abs(input_dir) > 0.1:
			new_state = "Walk"
		else:
			new_state = "Idle"
		
	if new_state != state:
		state = new_state
		anim_state.travel(state)
