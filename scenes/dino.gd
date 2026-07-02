extends CharacterBody2D

const GRAVITY: int=4200
const JUMP_SPEED: int=-1800

func _physics_process(delta):
	velocity.y +=GRAVITY*delta
	if is_on_floor():
		$CollisionShape2D.disabled=false
		if Input.is_action_pressed("ui_accept"):
			velocity.y =JUMP_SPEED
			$AudioStreamPlayer2D.play()
		elif Input.is_action_pressed("ui_down"):
			$AnimatedSprite2D.play("duck")
			$CollisionShape2D.disabled=true
		else:
			$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("jump")
		
	move_and_slide()
