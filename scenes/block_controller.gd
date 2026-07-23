extends TextureButton

@export var value := 0:
	set(v):
		value = int(v)
		match value:
			0:
				$WhiteBlock.hide()
				$RedBlock.hide()
				$HitBlock.hide()
				$BlackBlock.hide()
			1:
				$WhiteBlock.show()
				$RedBlock.hide()
				$HitBlock.hide()
				$BlackBlock.hide()
			2:
				$WhiteBlock.hide()
				$RedBlock.show()
				$HitBlock.hide()
				$BlackBlock.hide()
			3:
				$WhiteBlock.hide()
				$RedBlock.hide()
				$HitBlock.show()
				$BlackBlock.hide()
			4:
				$WhiteBlock.hide()
				$RedBlock.hide()
				$HitBlock.hide()
				$BlackBlock.show()

func get_data():
	return value


func set_data(v):
	value = int(v) % 5


func _on_pressed() -> void:
	value = (value  + 1) % 5
	pass # Replace with function body.
