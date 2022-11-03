extends Node2D


const bullet_scene = preload("res://BulletHellProjectilePatterns/Bullet.tscn")

onready var shootTimer = $ShootTimer
onready var rotator = $Rotator

export (int) var rotate_speed = 100
export (float) var shooter_timer_wait_time = 0.2
export (int) var spawn_point_count = 4
export (int) var radius = 50

func _ready():
	generate_spawn_points()
	shootTimer.wait_time = shooter_timer_wait_time
	shootTimer.start()
	
func _process(delta):
	var new_rotation = rotator.rotation_degrees + rotate_speed * delta
	rotator.rotation_degrees =  fmod(new_rotation, 360)
	should_reset()

func _on_ShootTimer_timeout():
	for s in rotator.get_children():
		var bullet = bullet_scene.instance()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation

func should_reset():
	if Input.is_action_just_pressed("ui_accept"):
		remove_all_spawn_points()
		generate_spawn_points()
		shootTimer.wait_time = shooter_timer_wait_time
		shootTimer.start()
	
func generate_spawn_points():
	var step = 2 * PI / spawn_point_count
	for i in range(spawn_point_count):
		
		var spawn_point_sprite = Sprite.new()
		spawn_point_sprite.texture = preload("res://icon.png")
		spawn_point_sprite.scale = Vector2(0.1,0.1)
		spawn_point_sprite.modulate = Color(1,1,1)
		
		var spawn_point = Node2D.new()
		spawn_point.add_child(spawn_point_sprite)
		
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator.add_child(spawn_point)

func remove_all_spawn_points():
	for s in rotator.get_children():
		s.queue_free()
