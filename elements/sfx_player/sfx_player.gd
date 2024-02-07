extends AudioStreamPlayer

enum AUDIO_TRACKS {
	knifeHit, targetExplosion, woodHit
}

const AUDIO_TRACKS_MAP := {
	AUDIO_TRACKS.knifeHit: preload("res://assets/audio/knife_hit.wav"),
	AUDIO_TRACKS.targetExplosion: preload("res://assets/audio/target_explosion.wav"),
	AUDIO_TRACKS.woodHit:preload("res://assets/audio/wood_hit.wav")
}

func play_track(track: AUDIO_TRACKS):
	stream = AUDIO_TRACKS_MAP.get(track)
	play()
