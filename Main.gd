extends Spatial

signal kingdom_selected

const KingdomSelector = preload("res://KingdomSelector.gd")

var selected: KingdomSelector

func _ready():
	select($HUD/Selector.selectors[0])

func select(kingdom_selector: KingdomSelector):
	# Deselect the currently selected and select the new kingdom
	if selected:
		selected.deselect()
	
	kingdom_selector.select()
	selected = kingdom_selector
	emit_signal("kingdom_selected", kingdom_selector.kingdom)
