extends Node3D

func _ready() -> void:
	dim_all_lights(self)

func dim_all_lights(current_node: Node) -> void:
	if current_node is MeshInstance3D:
		for i in range(current_node.get_surface_override_material_count()):
			var mat = current_node.get_surface_override_material(i)
			if mat and "emiWHITE" in mat.resource_name:
				mat.emission_enabled = false
		

		if current_node.mesh:
			for i in range(current_node.mesh.get_surface_count()):
				var mat = current_node.mesh.surface_get_material(i)
				if mat and "emiWHITE" in mat.resource_name:
					mat.set("emission_enabled", false)
					mat.set("emission_energy_multiplier", 0.0)

	for child in current_node.get_children():
		dim_all_lights(child)
