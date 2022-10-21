extends Spatial

var can_select: bool = false
export(NodePath) onready var highlight = get_node("MeshInstance/highligt") as MeshInstance

func _on_Area_mouse_entered():
	can_select = true
	print('can_select')
func _on_Area_mouse_exited():
	can_select = false
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("rotate"):
		if can_select:
			print('selected')
			highlight.visible = true
