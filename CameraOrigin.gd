extends Spatial

const Kingdom = preload("res://Kingdom.gd")

# Convert a quaternion into a basis and update the transform
func set_basis(c: Quat):
	self.transform.basis = Basis(c)

# Swivel the camera to point to the newly selected kingdom
func _on_kingdom_selected(kingdom: Kingdom):
	# Note that in this case a simple interpolation on
	# the eular angles seems to work just fine:
	#	$Tween.interpolate_property(
	#		self,
	#		"rotation",
	#		self.rotation,
	#		kingdom.rotation,
	#		1,
	#		Tween.TRANS_LINEAR,
	#		Tween.EASE_IN_OUT
	#	)
	#
	# We use quaternions here just to attempt to be
	# purests and I think it animates a bit nicer.
	$Tween.interpolate_method(
		self,
		"set_basis",
		Quat(self.transform.basis),
		Quat(kingdom.transform.basis),
		.4,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
	)
	$Tween.start()
