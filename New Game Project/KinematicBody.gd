extends KinematicBody

const SPELL = preload("res://FireBall.tscn")
onready var animator: AnimationPlayer = $Wizard/AnimationPlayer

export(NodePath) onready var SpellPosition = get_node("SpellPosition") as Position3D
var speed = 5
var velocity: Vector3 = Vector3.ZERO

var h_acceleration = 0.1
var h_sensibility = 0.1

var attacking: bool = false

func _physics_process(_delta):
	move()
	animate()

func move():
	velocity = Vector3.ZERO
	if Input.is_action_pressed("ui_down"):
		velocity += -transform.basis.z * speed
	if Input.is_action_pressed("ui_up"):
		velocity += transform.basis.z * speed
	
	if Input.is_action_pressed("ui_right"):
		rotate_y(-lerp( 0, h_sensibility, h_acceleration))
	if Input.is_action_pressed("ui_left"):
		rotate_y(lerp( 0, h_sensibility, h_acceleration))
		
	velocity = move_and_slide(velocity, Vector3.UP, true)

func animate():
	if Input.is_action_just_pressed("Attack") and !attacking:
		animator.play("Spell1")
		attacking = true
		#spawn_spell()
	elif !attacking:
		if velocity == Vector3.ZERO:
			animator.play("Idle")
		if velocity.z != 0:
			animator.play("Walk")

func spawn_spell() -> void:
	var spell = SPELL.instance()
	get_tree().root.call_deferred("add_child", spell)
	spell.global_transform = SpellPosition.global_transform
	

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'Spell1':
		attacking = false
