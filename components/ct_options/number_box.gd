@tool
extends HBoxContainer


@export var title := "":
	set(v):
		title = v
		$Label.text = title


@export var font_size := 24:
	set(v):
		font_size = v
		if $LineEdit and $LineEdit.get_line_edit():
			$LineEdit.get_line_edit().add_theme_font_size_override(&"font_size", font_size)


@export var number := 0:
	set(v):
		number = v
		$LineEdit.value = number


func get_data():
	return $LineEdit.value
