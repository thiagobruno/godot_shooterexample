extends Sprite

export var velocidade = 10
var direction = Vector2.ZERO

func _ready():
	if direction == Vector2.ZERO:
		direction.x = 300
		
func _process(delta):
	position += (direction.normalized()*300) * velocidade * delta

func _on_visibility_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	# Se colidir com uma caixa...
	if body.is_in_group("box"):
		body._die()
