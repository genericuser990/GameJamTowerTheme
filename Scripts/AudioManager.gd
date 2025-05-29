extends Node

onready var eatBoatPlayer = $EatBoat
onready var selectPlayer = $Select
onready var titleSongPlayer = $TitleSong
onready var gameSongPlayer = $GameSong
onready var onButtonPlayer = $OnButton

var currentSong

func _ready():
	gameSongPlayer.connect("finished", self, "loopSong")
	titleSongPlayer.connect("finished", self, "loopSong")
	
	currentSong = titleSongPlayer
	currentSong.playing = true
	Global.setAudioManager(self)

func playSelect():
	selectPlayer.playing = true
	
func playEatBoat():
	eatBoatPlayer.playing = true
	
func playOnButton():
	onButtonPlayer.playing = true

func setBgSong(song):
	if song == 0 && currentSong != titleSongPlayer:
		currentSong.playing = false
		currentSong = titleSongPlayer
		currentSong.playing = true
	if song == 1 && currentSong != gameSongPlayer:
		currentSong.playing = false
		currentSong = gameSongPlayer
		currentSong.playing = true
	

func loopSong():
	currentSong.playing = true
