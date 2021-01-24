extends Node2D

func play_music(music_clip : AudioStream):
	$music/music_player.stream = music_clip
	$music/music_player.play()
	
