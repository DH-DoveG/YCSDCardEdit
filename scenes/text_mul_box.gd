extends VBoxContainer


func get_data():
	return {
		"size": $EffectSize.get_data(),
		"text": $TextEdit.text
	}

func set_data(data):
	$EffectSize.set_data(data["size"])
	$TextEdit.text = data["text"]


func _ready() -> void:
	var v: VScrollBar = $TextEdit.get_v_scroll_bar()
	v.custom_minimum_size.x = 40
