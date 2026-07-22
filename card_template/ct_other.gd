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


var idata = null


func get_data():
	return idata
	#return {
		#"image": [
			#{
				#"obj": $CardImageStack/Template.texture,
				#"scale": $CardImageStack/Template.offset_transform_scale,
				#"offset": $CardImageStack/Template.offset_transform_position,
				#"rotation": $CardImageStack/Template.offset_transform_rotation
			#}
		#],
		#"name": card_name.text,
		#"type": card_type.text,
		#"lv": int(card_lv.text),
		#"tag_slot1": card_tag_slot_1.text.split("·"),
		#"tag_slot2": card_tag_slot_2.text.split("·"),
		#"effect": card_effect.text
	#}


func set_data(data: Dictionary):
	idata = data
	if data.has("background_color"):
		card_background.color = Color(data["background_color"])
	# [  { "obj": IMAGE RESOURCE, "scale": Vector2, "offset": Vector2, "rotation": float }  ]
	if data.has("image"):
		var data_image = data["image"]
		print("DATA IMAGE: ", data_image)
		#print("SIZE: ", data_image.size())
		for image in data_image:
			print("IMAGE: ", image)
			$CardImageStack/Template.texture = ImageTexture.create_from_image(image["obj"])
			$CardImageStack/Template.offset_transform_scale = Vector2(image["scale"]["x"], image["scale"]["y"])
			$CardImageStack/Template.offset_transform_position = Vector2(image["offset"]["x"], image["offset"]["y"]) * 3.4615
			$CardImageStack/Template.offset_transform_rotation = deg_to_rad(image["rotation"])
			pass
	if data.has("name"):
		card_name.text = data["name"]
	if data.has("type"):
		card_type.text = data["type"]
	if data.has("lv"):
		card_lv.text = data["lv"]
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
