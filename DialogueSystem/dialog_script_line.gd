extends HBoxContainer

@onready var line_read: AudioStreamPlayer = $LineRead

@export var triggered_dialog: Control ##Set a script line to play when this one completes it's audio

func _on_line_read_finished() -> void:
	visible=false
	if is_instance_valid(triggered_dialog):
		triggered_dialog.reparent(get_parent())
		triggered_dialog.line_read.play()
	queue_free()

func set_text(text: String) -> void:
	$CharacterTextBackground/DialogBoxText.text = text
