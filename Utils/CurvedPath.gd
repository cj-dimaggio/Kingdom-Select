# This file has been adapted from https://github.com/dbp8890/line-renderer
extends ImmediateGeometry

class_name CurvedPath

export var curve_amount = 0.5
export var number_of_points = 50
export var thickness = 0.005
export var start: Vector3
export var end: Vector3

func _init(_start: Vector3, _end: Vector3):
	start = _start
	end = _end

func _process(_delta):
	if not start or not end:
		return

	var camera = get_viewport().get_camera()
	if camera == null:
		return
		
	# We will use billboarding to keep the line facing the camera
	var cameraOrigin = to_local(camera.get_global_transform().origin)

	# We'll just place the bezier control point right in the middle
	var mid = lerp(start, end, 0.5)
	# We want to draw the curve *away* from the center of the globe
	# (which we happen to know is exactly in the center of the scene)
	# so we push the control point in the direction opposite the center
	mid += mid.direction_to(Vector3.ZERO) * curve_amount * -1

	clear()
	begin(Mesh.PRIMITIVE_TRIANGLES)
	for i in range(number_of_points - 1):
		# t1 and t2 are where in the interpalation
		# of the line we are. (t2 being one cycle ahead of t1)
		var t1 = i / float(number_of_points)
		var t2 = (i + 1) / float(number_of_points)
		
		# Our bezier curve is made up of several straight
		# lines. A is the start and B is the end of this
		# loop's segment
		var A = bezier_point(mid, t1)
		var B = bezier_point(mid, t2)
		
		var AB = B - A;
		# The offset from A/B to keep line thickness in the camera's
		# perspective
		var orthogonal = (cameraOrigin - ((A + B) / 2)).cross(AB).normalized() * thickness;
		
		# Calculate the points of the plane we'll draw
		# to show the bezier curve with the configured thickness
		var AtoABStart = A + orthogonal
		var AfromABStart = A - orthogonal
		var BtoABEnd = B + orthogonal
		var BfromABEnd = B - orthogonal
	
		# Draw the plane and map the x-axis of the texture
		# along the *entire* bezier curve. It's possible that
		# we should rasterize the curve to get the absolute
		# interpolation value of the texture but I think that
		# it should all be fairly uniform considering we know
		# our control point is directly in the middle of the line
		set_uv(Vector2(t1, 0))
		add_vertex(AtoABStart)
		set_uv(Vector2(t2, 0))
		add_vertex(BtoABEnd)
		set_uv(Vector2(t1, 1))
		add_vertex(AfromABStart)
		set_uv(Vector2(t2, 0))
		add_vertex(BtoABEnd)
		set_uv(Vector2(t2, 1))
		add_vertex(BfromABEnd)
		set_uv(Vector2(t1, 1))
		add_vertex(AfromABStart)
	end()

# Get the point on the bezier curve, given the control
# point, at the passed in lerp value
func bezier_point(control: Vector3, t: float):
	var q0 = start.linear_interpolate(control, t)
	var q1 = control.linear_interpolate(end, t)
	return q0.linear_interpolate(q1, t)
