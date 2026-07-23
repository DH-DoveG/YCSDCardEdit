@tool
extends VBoxContainer


@export var title := "":
	set(v):
		title = v
		$Title.text = title


func _on_add_tag_pressed() -> void:
	add_tag()


func add_tag(v = ""):
	var grid = $Grid
	
	var item := HBoxContainer.new()
	grid.add_child(item)
	item.size_flags_horizontal = SizeFlags.SIZE_EXPAND_FILL #"size_flags_horizontal"
	var remove := TextureButton.new()
	item.add_child(remove)
	remove.ignore_texture_size = true
	remove.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	remove.custom_minimum_size = Vector2(40, 40)
	remove.texture_normal = load("res://assets/icons/close.png")
	var line := LineEdit.new()
	item.add_child(line)
	line.custom_maximum_size.y = 40
	line.alignment = HORIZONTAL_ALIGNMENT_CENTER
	line.placeholder_text = "请输入特征"
	line.add_theme_font_size_override(&"font_size", 24)
	line.size_flags_horizontal = SizeFlags.SIZE_EXPAND_FILL
	line.name = "LineEdit"
	
	line.text = v
	
	remove.pressed.connect(func():
		item.queue_free()
	)
	grid.move_child($Grid/AddTag, grid.get_child_count())


func get_data():
	var items = $Grid.get_children()
	items.pop_back()
	var data = []
	for item in items:
		data.append(item.get_node("LineEdit").text)
	return data


func set_data(data):
	#print("DATA : ", data)
	for g in $Grid.get_children():
		if g.name != "AddTag":
			g.queue_free()
	for d in data:
		#_on_add_tag_pressed()
		add_tag(d)
		#var s = $Grid.get_children()
		#var n = s[s.size() - 2]
		#n.get_node("LineEdit").text = d
