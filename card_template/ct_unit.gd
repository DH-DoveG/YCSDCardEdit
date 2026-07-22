extends TextureRect


@onready var card_background: ColorRect = $CardBackground
@onready var card_image_stack: Control = $CardImageStack
@onready var card_name: AutoSizeLabel = $CardName
@onready var card_type: AutoSizeLabel = $CardType
@onready var card_lv: AutoSizeLabel = $CardLv
@onready var card_tag_slot_1: AutoSizeLabel = $CardTagSlot1
@onready var card_tag_slot_2: AutoSizeLabel = $CardTagSlot2
@onready var card_effect := $CardEffect
@onready var card_icon: TextureRect = $CardIcon
@onready var unit_ap: Label = $AP
@onready var unit_dp: Label = $DP
@onready var unit_sp: Label = $SP
@onready var unit_attack_gc: GridContainer = $AttackGC

var attack_range := {}

var idata = null


func get_data():
	return idata


func set_data(data: Dictionary):
	idata = data
	if data.has("background_color"):
		card_background.color = Color(data["background_color"])
	# [  { "obj": IMAGE RESOURCE, "scale": Vector2, "offset": Vector2, "rotation": float }  ]
	if data.has("image"):
		var data_image = data["image"]
		for image in data_image:
			$CardImageStack/Template.texture = ImageTexture.create_from_image(image["obj"])
			$CardImageStack/Template.offset_transform_scale = Vector2(image["scale"]["x"], image["scale"]["y"])
			$CardImageStack/Template.offset_transform_position = Vector2(image["offset"]["x"], image["offset"]["y"]) * 3.4615
			$CardImageStack/Template.offset_transform_rotation = deg_to_rad(image["rotation"])
	if data.has("name"):
		card_name.text = data["name"]
	if data.has("type"):
		card_type.text = data["type"]
	if data.has("lv"):
		card_lv.text = str(data["lv"])
	if data.has("tag_slot1"):
		card_tag_slot_1.text = "·".join(data["tag_slot1"])
	if data.has("tag_slot2"):
		card_tag_slot_2.text = "·".join(data["tag_slot2"])
	if data.has("effect_size"):
		card_effect._max_size = data["effect_size"]
	if data.has("effect"):
		card_effect.text = data["effect"]
	if data.has("icon"):
		#card_icon.texture = load("")
		pass
	if data.has("unit_ap"):
		unit_ap.text = data["unit_ap"]
	if data.has("unit_dp"):
		unit_dp.text = data["unit_dp"]
	if data.has("unit_sp"):
		unit_sp.text = data["unit_sp"]
	# { "size": 5, "grid": [0, 0, 0, 1, 2, ...] }
	# size 确定尺寸（不能单独设置 x与y 因为这会让网格单元变形）
	# 0: 空白
	# 1: 白色
	# 2: 红色
	# 3: 暴击区
	# 4: 黑色
	if data.has("unit_attack_range"):
		for item in $AttackGC.get_children():
			item.queue_free()
		var unit_attack_range = data["unit_attack_range"]
		attack_range = unit_attack_range
		unit_attack_gc.columns = unit_attack_range["size"]
		for item in unit_attack_range["grid"]:
			var node = null
			match item:
				0:
					node = $Template/None.duplicate()
				1:
					node = $Template/WhiteBlock.duplicate()
				2:
					node = $Template/RedBlock.duplicate()
				3:
					node = $Template/HitBlock.duplicate()
				4:
					node = $Template/BlackBlock.duplicate()
			if node:
				node.show()
				unit_attack_gc.add_child(node)
