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


func set_data(data):
	$CardBase/CardType/LineEdit.selected = 0
	#$CardBase/CardType/LineEdit.selected = data["type"]
	$CardBase/CardName.set_data(data["name"])
	$CardBase/CardLv.set_data(data["lv"])
	$CardBase/CardTagSlot1.set_data(data["tag_slot1"])
	$CardBase/CardTagSlot2.set_data(data["tag_slot2"])
	$CardBase/CardEffect.set_data({ "size": data["effect_size"], "text": data["effect"] })
	$CardBase/CardImage.set_data(data["image"])
	$AP.set_data(data["unit_ap"])
	$DP.set_data(data["unit_dp"])
	$SP.set_data(data["unit_sp"])
	$GridRange.set_data(data["unit_attack_range"])
