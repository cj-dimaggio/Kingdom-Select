extends PanelContainer

const KingdomSelector = preload("res://KingdomSelector.tscn")

var selectors = []

func _ready():
	# Create a KingdomSelector for each kingdom on the globe
	for kingdom in get_tree().get_nodes_in_group("kingdoms"):
		var selector = KingdomSelector.instance()
		selector.kingdom = kingdom
		$MarginContainer/HBoxContainer.add_child(selector)
		selector.connect('clicked', self.owner, 'select')
		selectors.append(selector)
