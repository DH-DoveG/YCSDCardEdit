extends TextureButton

@export var value = 0:
	set(v):
		value = v
		match v:
			0:
				$WhiteBlock.hide()
				$RedBlock.hide()
				$HitBlock.hide()
				$BlackBlock.hide()
				pass
			1:
				$WhiteBlock.show()
				$RedBlock.hide()
				$HitBlock.hide()
				$BlackBlock.hide()
				pass
			2:
				$WhiteBlock.hide()
				$RedBlock.show()
				$HitBlock.hide()
				$BlackBlock.hide()
				pass
			3:
				$WhiteBlock.hide()
				$RedBlock.hide()
				$HitBlock.show()
				$BlackBlock.hide()
				pass
			4:
				$WhiteBlock.hide()
				$RedBlock.hide()
				$HitBlock.hide()
				$BlackBlock.show()
				pass

func get_data():
	return value


func set_data(v):
	value = v


func _on_pressed() -> void:
	value = (value  + 1) % 5
	pass # Replace with function body.
