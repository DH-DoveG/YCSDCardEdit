extends VBoxContainer


func _ready() -> void:
	var popup = $CardBase/CardType/LineEdit.get_popup()
	popup.add_theme_font_size_override(&"font_size", 32)
	popup.add_theme_constant_override(&"font_separator_size", 32)
	popup.add_theme_constant_override(&"v_separation", 32)


func get_data():
	var data = {
		"type": $CardBase/CardType/LineEdit.get_item_text($CardBase/CardType/LineEdit.selected),
		"name": $CardBase/CardName.get_data(),
		"lv": $CardBase/CardLv.get_data(),
		"tag_slot1": $CardBase/CardTagSlot1.get_data(),
		"tag_slot2": $CardBase/CardTagSlot2.get_data(),
		"effect_size": $CardBase/CardEffect.get_data()["size"],
		"effect": $CardBase/CardEffect.get_data()["text"],
		"image": $CardBase/CardImage.get_data(),
		"unit_ap": $AP.get_data(),
		"unit_dp": $DP.get_data(),
		"unit_sp": $SP.get_data(),
		"unit_attack_range": $GridRange.get_data()
	}
	return data
