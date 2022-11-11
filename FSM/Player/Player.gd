# Character that moves and jumps.
class_name Player
extends KinematicBody2D

# Horizontal speed in pixels per second.
export var speed := 500.0
# Vertical acceleration in pixel per second squared.
export var gravity := 3500.0
# Vertical speed applied when jumping.
export var jump_impulse := 1200.0

var velocity

onready var fsm := $StateMachine
