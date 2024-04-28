extends Node

var channels: Dictionary
var timed_streams: Array[TimedStream] = []
var tts_enabled: bool = false

enum Channel {
	MASTER,
	SOUND_EFFECT,
	BACKGROUND_MUSIC,
	DIALOG
}

const MIN_VOLUME: float = 0.0
const MAX_VOLUME: float = 1.0

signal channel_volume_changed(channel: Channel, volume: float)

class TimedStream:
	var channel: Channel
	var stream_id: int
	var start_time: float
	var duration: float
	var ease_out_time: float
	
	func _init(_channel: Channel, _stream_id: int, _start_time: float, _duration: float, _ease_out_time: float = 1000.0):
		channel = _channel
		stream_id = _stream_id
		start_time = _start_time
		duration = _duration
		ease_out_time = _ease_out_time
		
	func get_remaining_time() -> float:
		return start_time + duration - Time.get_ticks_msec()
		
	func update(_delta: float):
		if get_remaining_time() < ease_out_time:
			SoundManager.get_current_channel_player(channel).get_stream_playback().set_stream_volume(stream_id, linear_to_db(
				get_remaining_time() / ease_out_time
			))
			
	func stop():
		SoundManager.get_current_channel_player(channel).get_stream_playback().stop_stream(stream_id)

func _ready():
	channels = {
		Channel.MASTER: create_channel_dict("Master", []),
		Channel.SOUND_EFFECT: create_channel_dict("SoundEffect", [
			create_polyphnic_audio_stream("SoundEffect", 32)
		]),
		Channel.BACKGROUND_MUSIC: create_channel_dict("BackgroundMusic", [
			create_audio_stream_player("BackgroundMusicChannel1"),
			create_audio_stream_player("BackgroundMusicChannel2")
		]),
		Channel.DIALOG: create_channel_dict("Dialog", [
			create_polyphnic_audio_stream("Dialog", 8)
		])
	}
	SaveFileManager.save_file_loaded.connect(on_save_file_loaded)
	SaveFileManager.save_file_saving.connect(on_save_file_saving)
	
func on_save_file_loaded(save_file: Dictionary) -> void:
	for channel in save_file.sound_settings.channels:
		set_channel_volume(int(channel), save_file.sound_settings.channels[channel].volume)
	tts_enabled = save_file.sound_settings.tts_enabled
	
func on_save_file_saving(save_file: Dictionary) -> void:
	save_file.sound_settings = {
		channels = {},
		tts_enabled = tts_enabled
	}
	for channel in channels.keys():
		save_file.sound_settings.channels[channel] = {
			"volume": get_channel_volume(channel)
		}
	
func create_audio_stream_player(bus: String) -> AudioStreamPlayer:
	var audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)
	audio_stream_player.max_polyphony = 1
	audio_stream_player.bus = bus
	audio_stream_player.process_mode = Node.PROCESS_MODE_ALWAYS
	return audio_stream_player
	
func create_polyphnic_audio_stream(bus: String, polyphony: int) -> AudioStreamPlayer:
	var audio_stream = AudioStreamPlayer.new()
	add_child(audio_stream)
	audio_stream.stream = AudioStreamPolyphonic.new()
	audio_stream.max_polyphony = polyphony
	audio_stream.bus = bus
	audio_stream.play()
	return audio_stream
	
func create_channel_dict(bus: String, players: Array[AudioStreamPlayer]) -> Dictionary:
	return {
		"players": players,
		"current_player_id": 0,
		"volume": 0.5,
		"bus": bus
	}
	
func get_current_channel_player(channel: Channel) -> AudioStreamPlayer:
	return channels[channel].players[channels[channel].current_player_id]
	
func set_current_channel_player(channel: Channel, player_id: int) -> void:
	channels[channel].current_player_id = player_id
	
func play_sound(channel: Channel, audio_stream: AudioStream, duration: float = 0.0) -> void:
	var player: AudioStreamPlayer = get_current_channel_player(channel)
	match channel:
		Channel.SOUND_EFFECT:
			if player.has_stream_playback():
				var stream_id: int = player.get_stream_playback().play_stream(audio_stream)
				if duration == 0.0 and audio_stream.get_length() != 0.0:
					duration = audio_stream.get_length() * 1000
				if duration != 0.0:
					timed_streams.append(TimedStream.new(
						channel,
						stream_id,
						Time.get_ticks_msec(),
						duration,
						1000.0
					))
		Channel.BACKGROUND_MUSIC:
			if audio_stream == player.stream:
				return
			var fade_out_tween = create_tween()
			fade_out_tween.tween_method(
				func(volume_linear: float):
					set_bus_volume(player.bus, volume_linear),
				1.0,
				0.0,
				2.0)
			fade_out_tween.finished.connect(func():
				player.stop()
				fade_out_tween.kill())
			fade_out_tween.play()
			set_current_channel_player(
				channel,
				channels[channel].current_player_id + 1 if channels[channel].current_player_id < channels[channel].players.size() - 1 else 0
			)
			player = get_current_channel_player(channel)
			player.stream = audio_stream
			if audio_stream is AudioStreamMP3:
				player.stream.set_loop(true)
			elif audio_stream is AudioStreamWAV:
				player.stream.loop_mode = AudioStreamWAV.LOOP_FORWARD
				player.stream.loop_end = audio_stream.mix_rate * audio_stream.get_length()
			player.play()
			var fade_in_tween = create_tween()
			fade_in_tween.tween_method(
				func(volume_linear: float):
					set_bus_volume(player.bus, volume_linear),
				0.0,
				1.0,
				2.0)
			fade_in_tween.finished.connect(func():
				fade_in_tween.kill())
			fade_in_tween.play()
			
func set_bus_volume(bus: String, volume: float) -> void:
	if volume >= MIN_VOLUME and volume <= MAX_VOLUME:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), linear_to_db(volume))

func set_channel_volume(channel: Channel, volume: float) -> void:
	if volume >= MIN_VOLUME and volume <= MAX_VOLUME:
		set_bus_volume(channels[channel].bus, volume)
		channels[channel].volume = volume
		channel_volume_changed.emit(channel, volume)
		
func get_channel_volume(channel: Channel) -> float:
	return channels[channel].volume

func play_tts(text: String) -> void:
	if tts_enabled:
		if DisplayServer.tts_is_speaking():
			DisplayServer.tts_stop()
		var voices = DisplayServer.tts_get_voices_for_language("en")
		var voice_id = voices[0]
		DisplayServer.tts_speak(text, voice_id, int(
			min(channels[Channel.MASTER].volume, channels[Channel.DIALOG].volume) * 100
		))
		
func get_volume(bus: String) -> float:
	return AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus))
	
func _process(delta: float) -> void:
	for timed_stream in timed_streams:
		timed_stream.update(delta)
		if timed_stream.get_remaining_time() <= 0.0:
			timed_stream.stop()
			timed_streams.erase(timed_stream)
