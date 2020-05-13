extends MeshInstance

export var delay = 0.5

func _ready():
	# Start the Grow animation after a configurable
	# delay
	var timer = Timer.new()
	timer.set_wait_time(delay)
	timer.set_one_shot(true)
	self.add_child(timer)
	timer.start()
	yield(timer, "timeout")
	timer.queue_free()
	$AnimationPlayer.play("Grow")
