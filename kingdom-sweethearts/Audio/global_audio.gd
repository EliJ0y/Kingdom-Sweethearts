extends AudioStreamPlayer2D


func play_music(music: AudioStream):
	if stream == music:
		return
		
	stream = music
	volume_db = -10.0
	play()
	
func play_fx(stream: AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "fx_player"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	
	fx_player.queue_free()
