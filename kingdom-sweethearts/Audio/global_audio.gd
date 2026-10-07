extends AudioStreamPlayer2D


func play_music(music: AudioStream):
	if stream == music:
		return
		
	stream = music
	play()


func play_fx(stream: AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "fx_player"
	fx_player.volume_db = volume
	fx_player.bus = "Sound"
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	
	fx_player.queue_free()
