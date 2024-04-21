extends Node

const MIN_VOLUME: float = -70.0
const MAX_VOLUME: float = 10.0

enum Channel {
	SOUND_EFFECT,
	BACKGROUND_MUSIC
}

class TimedStream:
	var channel: Channel
	var stream_id: int
	var start_time: float
	var duration: float
	
	func _init(_channel: Channel, _stream_id: int, _start_time: float, _duration: float):
		channel = _channel
		stream_id = _stream_id
		start_time = _start_time
		duration = _duration

var channels: Dictionary
var timed_streams: Array[TimedStream] = []

signal channel_volume_changed(channel: Channel, volume: float)

func _ready():
	var sound_effect_player = AudioStreamPlayer.new()
	add_child(sound_effect_player)
	sound_effect_player.stream = AudioStreamPolyphonic.new()
	sound_effect_player.max_polyphony = 32
	sound_effect_player.bus = "SoundEffect"
	sound_effect_player.play()
	channels = {
		Channel.SOUND_EFFECT: create_channel_dict([sound_effect_player]),
		Channel.BACKGROUND_MUSIC: create_channel_dict([
			create_audio_stream_player("BackgroundMusicChannel1"),
			create_audio_stream_player("BackgroundMusicChannel2")
		])
	}
	
func create_audio_stream_player(bus: String) -> AudioStreamPlayer:
	var audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)
	audio_stream_player.max_polyphony = 1
	audio_stream_player.bus = bus
	audio_stream_player.process_mode = Node.PROCESS_MODE_ALWAYS
	return audio_stream_player
	
func create_channel_dict(players: Array[AudioStreamPlayer]) -> Dictionary:
	return {
		"players": players,
		"current_player_id": 0
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
				if duration != 0.0:
					timed_streams.append(TimedStream.new(
						channel,
						stream_id,
						Time.get_ticks_msec(),
						duration
					))
		Channel.BACKGROUND_MUSIC:
			var fade_out_tween = create_tween()
			fade_out_tween.tween_method(
				func(volume_linear: float):
					AudioServer.set_bus_volume_db(AudioServer.get_bus_index(player.bus), linear_to_db(volume_linear)),
				1.0,
				0.0,
				1.0)
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
				player.stream.loop_end = audio_stream.mix_rate * 60.0
			player.play()
			var fade_in_tween = create_tween()
			fade_in_tween.tween_method(
				func(volume_linear: float):
					AudioServer.set_bus_volume_db(AudioServer.get_bus_index(player.bus), linear_to_db(volume_linear)),
				0.0,
				1.0,
				1.0)
			fade_in_tween.finished.connect(func():
				fade_in_tween.kill())
			fade_in_tween.play()

func set_volume(channel: Channel, volume: float) -> void:
	if volume >= MIN_VOLUME and volume <= MAX_VOLUME:
		channels[channel].player.volume_db = volume
		channel_volume_changed.emit(channel, volume)
		
func get_volume(channel: Channel) -> float:
	return channels[channel].player.volume_db
	
func _process(_delta: float) -> void:
	for timed_stream in timed_streams:
		if timed_stream.start_time + timed_stream.duration <= Time.get_ticks_msec():
			channels[timed_stream.channel].player.get_stream_playback().stop_stream(timed_stream.stream_id)
			timed_streams.erase(timed_stream)
