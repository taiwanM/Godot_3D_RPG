extends Spatial

var camroot_h = 0
var camroot_v = 0

var cam_v_min = -55
var cam_v_max = 75

var h_sensibility = 0.1
var v_sensibility = 0.1

var h_acceleration = 10
var v_acceleration = 10

var rotate: bool = false

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$h/v/Camera.add_exception(get_parent())
	
func _input(event):
	if event is InputEventMouseMotion and rotate:
		camroot_h += -event.relative.x * h_sensibility
		camroot_v += event.relative.y * v_sensibility

func _physics_process(delta):
	camroot_v = clamp(camroot_v, cam_v_min, cam_v_max)
	if Input.is_action_just_pressed("rotate"):
		rotate = true
	if Input.is_action_just_released("rotate"):
		rotate = false
	$h.rotation_degrees.y = lerp($h.rotation_degrees.y, camroot_h, delta * h_acceleration)
	$h.rotation_degrees.x = lerp($h/v.rotation_degrees.x, camroot_v, delta * v_acceleration)
