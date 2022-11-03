extends Node2D


const speed = 100

func _ready():
	$Sprite.modulate = Color(1,0,0)

func _process(delta):
	position += transform.x * speed * delta

func _on_Timer_timeout() -> void:
	queue_free()
