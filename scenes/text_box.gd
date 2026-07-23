@tool
extends HBoxContainer

@export var title := "":
	set(v):
		title = v
		$Label.text = title


func get_data():
	return $LineEdit.text


func set_data(data):
	$LineEdit.text = data
