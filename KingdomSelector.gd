extends Control

signal clicked

const Kingdom = preload("res://Kingdom.gd")

var kingdom: Kingdom
var is_selected = false

func _ready():
	# Set initial colors and the kingdom label text
	set_bg_transparency(0)
	$Rect/Label.set("custom_colors/font_color", Color.white)	
	if kingdom:
		$Rect/Label.text = kingdom.kingdom_name

func select():
	is_selected = true
	# Make the background totally opaque
	$Tween.interpolate_method(
		self,
		"set_bg_transparency",
		rect_style().bg_color.a,
		1,
		0.2,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	# Transition the font color to black
	$Tween.interpolate_property(
		$Rect/Label, "custom_colors/font_color",
		$Rect/Label.get("custom_colors/font_color"),
		Color.black,
		0.2,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	$Tween.start()
	
func deselect():
	is_selected = false
	# Make the background color totally transparent
	$Tween.interpolate_method(
		self,
		"set_bg_transparency",
		rect_style().bg_color.a,
		0,
		0.2,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	# Transition the font color to white
	$Tween.interpolate_property(
		$Rect/Label, "custom_colors/font_color",
		$Rect/Label.get("custom_colors/font_color"),
		Color.white,
		0.2,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	$Tween.start()

func _on_mouse_entered():
	enter_hover()

func _on_mouse_exited():
	exit_hover()

# Surface mouse click events
func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed && not self.is_selected:
			emit_signal("clicked", self)
			
func enter_hover():
	if not self.is_selected:
		$Tween.interpolate_method(
			self,
			"set_bg_transparency",
			rect_style().bg_color.a,
			0.23,
			0.2,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT
		)
		$Tween.start()
		
func exit_hover():
	if not self.is_selected:
		$Tween.interpolate_method(
			self,
			"set_bg_transparency",
			rect_style().bg_color.a,
			0,
			0.2,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT
		)
		$Tween.start()

func set_bg_transparency(alpha):
	# This could easily be made much simpler if we
	# restructred our UI not to use both bg_color and
	# a shadow color but for prototyping purposes it
	# it should be okay
	var style = rect_style()
	style.bg_color.a = alpha
	style.shadow_color.a = alpha

func rect_style():
	return $Rect.get_stylebox("panel")
