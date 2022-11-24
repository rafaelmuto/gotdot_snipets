extends State

func process(_delta: float) -> void:
	
	if Input.is_action_pressed("ui_left"):
		player.animatedSprite.flip_h = true
	if Input.is_action_pressed("ui_right"):
		player.animatedSprite.flip_h = false
		
	player.animatedSprite.play("Run")
	

func physics_process(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	var input_direction_x: float = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if Input.is_action_just_pressed("ui_up"):
		state_machine.transition_to("Air", {do_jump = true})
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
