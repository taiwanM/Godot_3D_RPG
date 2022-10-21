extends MeshInstance
class_name FireBall

export(int ) var speed = 30
export(int ) var demage = 3

func _physics_process(delta: float) -> void:
	var forward_direction: Vector3 = global_transform.basis.z.normalized()
	global_translate(forward_direction * speed * delta)

func _on_Timer_timeout() -> void:
	queue_free()


func _on_Area_body_entered(body):
	if body is StaticBody:
		queue_free()
#	if body is Enemy:
#		body.update_health(demage)
#		queue_free()
