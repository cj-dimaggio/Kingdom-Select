extends Spatial

export(Material) var connector_material

func _ready():
	# Draw the bezier curves connecting each kingdom to the
	# next
	var kingdoms = get_tree().get_nodes_in_group("kingdoms")
	for i in kingdoms.size() - 1:
		var p1 = kingdoms[i].get_point_global_position()
		var p2 = kingdoms[i + 1].get_point_global_position()
		var path = CurvedPath.new(p1, p2)
		path.material_override = connector_material
		self.add_child(path)