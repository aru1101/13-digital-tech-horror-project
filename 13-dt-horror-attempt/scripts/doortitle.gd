extends Node3D

var duration: float = 1.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$door.play("RESET")
	$CanvasLayer/Button.show()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$aniTimer.start()
	$door.play("door open")
	$breatherand/breathe.stop()
	ambient_fade()
	$dooar/AudioStreamPlayer3D.play()

func _rand_timerB():
	var timeB = randi_range(3, 8)
	$breatherand.start(timeB)
	# print(timeB)

func _on_breatherand_timeout() -> void:
	$breatherand/breathe.play()
	_rand_timerB()


func _on_ani_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/morning.tscn")

func ambient_fade():
	var tween = create_tween()
	tween.tween_property($ambient, "volume_db", -80.0, duration)
	$ambient.stop()
	
