extends Spatial

const Kingdom = preload("res://Kingdom.gd")

func _process(_delta):
	# Keep the plane pointed towards the camera
	var camera = get_viewport().get_camera()
	if camera == null:
		return

	# Note that look_at will wipe out scaling from the transform
	# as well, so to preserve that store it in either a parent or
	# nested child node
	self.look_at(camera.global_transform.origin, Vector3(0, 1, 0))
	# look_at also seems to point the plane facing away from the camera,
	# which causes it to get culled. We just rotatee it
	self.rotate_object_local(Vector3(0,1,0), PI)

func _on_kingdom_selected(kingdom: Kingdom):
	# Put the indicator on top of the selected kingdom
	self.transform.origin = kingdom.get_point_global_position()

func _on_Main_kingdom_selected():
	pass # Replace with function body.
