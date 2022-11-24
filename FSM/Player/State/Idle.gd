extends State


# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	player.velocity = Vector2.ZERO


func process(_delta: float) -> void:
	player.animatedSprite.play('Idle')
	
	# If you have platforms that break when standing on them, you need that check for 
	# the character to fall.
	if not owner.is_on_floor():
		state_machine.transition_to('Air')
		return

	if Input.is_action_just_pressed('ui_up'):
		# As we'll only have one air state for both jump and fall, we use the `msg` dictionary 
		# to tell the next state that we want to jump.
		state_machine.transition_to('Air', {do_jump = true})
	elif Input.is_action_pressed('ui_left') or Input.is_action_pressed('ui_right'):
		state_machine.transition_to('Run')
		
	
