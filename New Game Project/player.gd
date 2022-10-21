extends MeshInstance

const SPELL = preload("res://FireBall.tscn")
onready var animator: AnimationPlayer = get_node("AnimationPlayer")
onready var enemy: MeshInstance = $"../enemy"
export(NodePath) onready var SpellPosition =  $"../aim" as Position3D

#func _process(_delta: float) -> void:
	

func spawn_spell() -> void:
	var spell = SPELL.instance()
	get_tree().root.call_deferred("add_child", spell)
	
	var transf_aux: Transform = SpellPosition.global_transform.looking_at(enemy.global_translation, Vector3.UP)
	var rotat_aux = transf_aux.basis
	print(rotat_aux)
	

	spell.global_transform = transf_aux
func _on_Timer_timeout():
	spawn_spell()
