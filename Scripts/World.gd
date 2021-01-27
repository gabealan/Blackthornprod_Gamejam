extends Node2D

var music_clip : AudioStream = load("res://Assets/Sounds/CreepyBackgroundMusicConvert_session.wav")
func _ready():
	audio_manager.play_music(music_clip)
