tool
extends Control

# Godot does not appear to have a simple 2d circle node
# so let's just create one

export var radius = 5.0 setget _set_radius
export var color: Color setget _set_color
export var outline_width = 1.0 setget _set_outline_width
export var outline_color: Color setget _set_outline_color

func _set_radius(val):
	radius = val
	update()

func _set_color(val):
	color = val
	update()

func _set_outline_width(val):
	outline_width = val
	update()

func _set_outline_color(val):
	outline_color = val
	update()

func _draw():
	var center = Vector2(self.rect_size.x / 2, self.rect_size.y / 2)
	# It might be smarter/more performant to implement the outline
	# manually with line calls but this is easier to write
	self.draw_circle(center, radius + outline_width, outline_color)
	self.draw_circle(center, radius, color)

