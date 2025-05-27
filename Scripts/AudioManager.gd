extends Node

onready var onEatBoat = $EatBoat
onready var onSelect = $Select

func _ready():
	Global.setAudioManager(self)

func playSelect():
	onSelect.playing = true
	
func playEatBoat():
	onEatBoat.playing = true
