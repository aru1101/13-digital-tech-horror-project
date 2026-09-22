extends MeshInstance3D

@export var scene = scene_file_path

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(owner.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact():
	# print("ok")
	if owner.name == "morningHouse":
		get_tree().change_scene_to_file("res://scenes/testtesttest.tscn")
