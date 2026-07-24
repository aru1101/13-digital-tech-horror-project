extends SpotLight3D

@onready var vary = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func timahh() -> void:
	if vary <= 2:
		$Timer.start(randi_range(0.4, 1.2))
	elif vary >= 3:
		$Timer.start(randi_range(1.3, 2.0))


func _on_timer_timeout() -> void:
	# print("off timer timeout")
	hide()
	%hanglight.hide()
	vary = randi_range(0, 4)
	if vary <= 2:
		var timertimerplswork = randf_range(0.025, 0.4)
		# print(timertimerplswork)
		$onTimer.start(timertimerplswork)
		# print("short")
	elif vary >= 3:
		var timeplswork = randf_range(1.0, 1.2)
		$onTimer.start(timeplswork)
		# print("long")
		# print(timeplswork)
	# code so that it has a low chance for light to be off for a longer period of time

func _on_on_timer_timeout() -> void:
	# print("on timer timeout")
	show()
	%hanglight.show()
	timahh()
