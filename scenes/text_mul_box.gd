extends VBoxContainer


func get_data():
	return {
		"size": $EffectSize.get_data(),
		"text": $TextEdit.text
	}
