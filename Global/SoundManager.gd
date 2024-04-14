extends Node

var sound_effect_player: AudioStreamPlayer
var background_music_player: AudioStreamPlayer

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

var channel_players: Dictionary
var timed_streams: Array[TimedStream] = []

signal channel_volume_changed(channel: Channel, volume: float)

func _ready():
	sound_effect_player = Globals.get_sound_effects_player()
	sound_effect_player.stream = AudioStreamPolyphonic.new()
	sound_effect_player.max_polyphony = 32
	sound_effect_player.play()
	background_music_player = Globals.get_background_music_player()
	background_music_player.max_polyphony = 1
	channel_players = {
		Channel.SOUND_EFFECT: sound_effect_player,
		Channel.BACKGROUND_MUSIC: background_music_player
	}
	
func play_sound(channel: Channel, audio_stream: AudioStream, duration: float = 0.0) -> void:
	var player: AudioStreamPlayer = channel_players[channel]
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
			player.stream = AudioStreamMP3.new()
			player.stream.set_loop(true)
			player.play()

func change_volume(channel: Channel, volume: float) -> void:
	channel_players[channel].volume_db = volume
	channel_volume_changed.emit(channel, channel_players[channel].volume_db)
	
func _process(_delta: float) -> void:
	for timed_stream in timed_streams:
		if timed_stream.start_time + timed_stream.duration <= Time.get_ticks_msec():
			channel_players[timed_stream.channel].get_stream_playback().stop_stream(timed_stream.stream_id)
			print("StartTime ", timed_stream.start_time)
			print("Duration ", timed_stream.duration)
			print("Current Time ", Time.get_ticks_msec())
			timed_streams.erase(timed_stream)
