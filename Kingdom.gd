extends Spatial

# Will be displayed on the HUD selector
export var kingdom_name: String

# Get the global transform of the kingdom indicator
# on the globe
func get_point_global_position():
	return $Point.global_transform.origin
