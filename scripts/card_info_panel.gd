extends ColorRect


signal card_type_changed
signal card_used_changed


var card_class = 1


func _ready() -> void:
	var popup = $CardTypeChoose.get_popup()
	popup.add_theme_font_size_override(&"font_size", 32)
	popup.add_theme_constant_override(&"font_separator_size", 32)
	popup.add_theme_constant_override(&"v_separation", 32)
	
	$CardTypeChoose.selected = 1
	_on_card_type_choose_item_selected(1)
	
	var vbar = $Scroll.get_v_scroll_bar()
	vbar.custom_minimum_size.x = 64


var card_info_panel_status = false
func _on_btn_pressed() -> void:
	card_info_panel_status = not card_info_panel_status
	var tween := get_tree().create_tween()
	if card_info_panel_status:
		tween.tween_property(self, "position:y", 224, 0.25)
	else:
		#tween.tween_property($CardInfoPanel, "position:y", 920, 0.25)
		tween.tween_property(self, "position:y", Config.real_size.y, 0.25)


func update():
	pass


func _on_card_type_choose_item_selected(index: int) -> void:
	match index:
		0:
			for node in $Scroll/M.get_children():
				node.queue_free()
			var option = preload("res://scenes/ct_unit_options.tscn").instantiate()
			$Scroll/M.add_child(option)
		1:
			for node in $Scroll/M.get_children():
				node.queue_free()
			var option = preload("res://scenes/ct_other_options.tscn").instantiate()
			$Scroll/M.add_child(option)
	card_class = index
	card_type_changed.emit(index)


func _on_used_change_pressed() -> void:
	var data = $Scroll/M.get_child(0).get_data()
	data["card_class"] = card_class
	card_used_changed.emit(data)
