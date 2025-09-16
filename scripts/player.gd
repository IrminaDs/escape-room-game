extends CharacterBody3D

@export var speed := 5.0
var can_move := true  # dodajemy flagę, czy gracz może się poruszać

func _physics_process(delta):
	if not can_move:
		# jeśli ruch zablokowany, zerujemy velocity i wychodzimy
		velocity.x = 0
		velocity.z = 0
		move_and_slide()
		return

	var move_vector := Vector3.ZERO
	var head = $XROrigin3D/XRCamera3D

	# Ruch względem kierunku kamery
	if Input.is_action_pressed("move_up"):
		move_vector += -head.global_transform.basis.z
	if Input.is_action_pressed("move_down"):
		move_vector += head.global_transform.basis.z
	if Input.is_action_pressed("move_left"):
		move_vector += -head.global_transform.basis.x
	if Input.is_action_pressed("move_right"):
		move_vector += head.global_transform.basis.x

	# Zerowanie komponentu Y, żeby poruszać się tylko po XZ
	move_vector.y = 0

	# Przypisanie velocity w CharacterBody3D
	if move_vector != Vector3.ZERO:
		velocity.x = move_vector.normalized().x * speed
		velocity.z = move_vector.normalized().z * speed
	else:
		velocity.x = 0
		velocity.z = 0

	# Grawitacja
	if not is_on_floor():
		velocity.y -= 9.8 * delta
	else:
		velocity.y = 0

	# Poruszanie się z kolizjami
	move_and_slide()
