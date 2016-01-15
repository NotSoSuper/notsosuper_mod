hook.Add("PlayerCanHearPlayersVoice", "notsosuper_HOOK_MUTE", function(listener, talker)
	if talker.PlayerMuted then return false end
end)
