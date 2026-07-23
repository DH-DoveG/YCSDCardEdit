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
		"image": $CardBase/CardImage.get_data()
	}
	return data


func set_data(data):
	match data["type"]:
		"精灵卡": $CardBase/CardType/LineEdit.selected = 0
		"战术卡": $CardBase/CardType/LineEdit.selected = 1
		"设备卡": $CardBase/CardType/LineEdit.selected = 2
		"装备卡": $CardBase/CardType/LineEdit.selected = 3
		"场地卡": $CardBase/CardType/LineEdit.selected = 4
	$CardBase/CardName.set_data(data["name"])
	$CardBase/CardLv.set_data(data["lv"])
	$CardBase/CardTagSlot1.set_data(data["tag_slot1"])
	$CardBase/CardTagSlot2.set_data(data["tag_slot2"])
	$CardBase/CardEffect.set_data({ "size": data["effect_size"], "text": data["effect"] })
	$CardBase/CardImage.set_data(data["image"])
