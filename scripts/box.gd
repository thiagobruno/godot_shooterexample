extends StaticBody2D

signal explode

func _ready():
	$autoKill.wait_time = 15
	$autoKill.start()

func _die():
	$box.queue_free()
	$collision.queue_free()
	$fumaca.play()
	$dropBox.play()
	_explode()
	emit_signal("explode")
	
func _explode():
	# Explode a caixa em fragmentos
	for f in get_children():
		if f is RigidBody2D:
			f.bounce = 0
			f.angular_velocity = randf() * 10
			var dir = randf() * (PI * 2)
			f.apply_impulse(Vector2.ZERO, Vector2(cos(dir), sin(dir)) * 200 + Vector2(0,50))

func _on_footsteps_body_exited(body):
	if body.is_in_group("player"):
		body.ground = "res://assets/audio/footsteps_grass.ogg"

func _on_footsteps_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.is_in_group("player"):
		var rb = get_node(str("frag", area_shape + 1))
		if weakref(rb).get_ref():
			body.ground = "res://assets/audio/footsteps_wood.ogg"
			var dir = randf() * (PI * 2)
			rb.angular_velocity = randf() * 1
			rb.apply_impulse(Vector2.ZERO, Vector2(cos(dir), sin(dir)) * 20)


func _on_autoKill_timeout():
	queue_free()
