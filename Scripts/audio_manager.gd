extends Node2D

func play_effects(audio_clip : AudioStream):
	for child in $effects.get_children():
		if child.playing == false:
			child.stream = audio_clip
			child.play()
			break
			
	
func play_music(music_clip : AudioStream):
	$music/music_player.stream = music_clip
#	$music/music_player.play()
	

func stop_effects(audio_clip : AudioStream):
	for child in $effects.get_children():
		if child.playing == true:
			child.stream = audio_clip
			child.stop()
			break
			
func play_walk_effects(audio_clip : AudioStream):
	for child in $walking.get_children():
		if child.playing == false:
			child.stream = audio_clip
			child.play()
			break
			
func stop_walk_effects(audio_clip : AudioStream):
	for child in $walking.get_children():
		if child.playing == true:
			child.stream = audio_clip
			child.stop()
			break

func walk_audio_stop():
	for child in $walking.get_children():
		if child.playing == true:
			child.stop()
			break
