if (!SERVER) then return end

local function notsosuper_CMD_MUTE(ply,cmd,args)
	if (ply:IsValid() && !ply:IsAdmin()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
	if not args[1] then notsosuper_MSG_PLY(ply,"You have not entered a player name.") return end
	
	local notsosuper_VAR_PLAYER = NOTSOSUPER_GLB_GETUSER(args[1])
	if notsosuper_VAR_PLAYER == false then NOTSOSUPER_MSG_PLY(ply,"The targeted player could not be found, or there were too many targets.") return end
	if ply == notsosuper_VAR_PLAYER then NOTSOSUPER_MSG_PLY(ply,"You cannot target yourself.") return end
	
	local notsosuper_VAR_NAME = NOTSOSUPER_VAR_PLAYER:Nick()
	local notsosuper_VAR_STEAMID = NOTSOSUPER_VAR_PLAYER:SteamID()
	
	local notsosuper_VAR_ADMINID = "(Console)"
	local notsosuper_VAR_ADMINNAME = "(Console)"
	local notsosuper_VAR_ADMINIP = "(Console)"
	if ply and type(ply) != "string" and ply:IsPlayer() then
		notsosuper_VAR_ADMINID = ply:SteamID()
		notsosuper_VAR_ADMINNAME = ply:Nick()
		notsosuper_VAR_ADMINIP = ply:IPAddress()
	end
	
	if not notsosuper_VAR_PLAYER.PlayerMuted then
		local notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was muted"
		notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
		notsosuper_VAR_PLAYER.PlayerMuted = true
		
		local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] muted "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."]"
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	end
end
concommand.Add("notsosuper_mute", notsosuper_CMD_MUTE)
lechat.AddCmd("/mute ", nil, notsosuper_CMD_MUTE)

local function notsosuper_CMD_UNMUTE(ply,cmd,args)
	if (ply:IsValid() && !ply:IsAdmin()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
	if not args[1] then notsosuper_MSG_PLY(ply,"You have not entered a player name.") return end
	
	local notsosuper_VAR_PLAYER = NOTSOSUPER_GLB_GETUSER(args[1])
	if notsosuper_VAR_PLAYER == false then NOTSOSUPER_MSG_PLY(ply,"The targeted player could not be found, or there were too many targets.") return end
	if ply == notsosuper_VAR_PLAYER then NOTSOSUPER_MSG_PLY(ply,"You cannot target yourself.") return end
	
	local notsosuper_VAR_NAME = NOTSOSUPER_VAR_PLAYER:Nick()
	local notsosuper_VAR_STEAMID = NOTSOSUPER_VAR_PLAYER:SteamID()
	
	local notsosuper_VAR_ADMINID = "(Console)"
	local notsosuper_VAR_ADMINNAME = "(Console)"
	local notsosuper_VAR_ADMINIP = "(Console)"
	if ply and type(ply) != "string" and ply:IsPlayer() then
		notsosuper_VAR_ADMINID = ply:SteamID()
		notsosuper_VAR_ADMINNAME = ply:Nick()
		notsosuper_VAR_ADMINIP = ply:IPAddress()
	end
	
	if notsosuper_VAR_PLAYER.PlayerMuted then
		local notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was unmuted"
		notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
		notsosuper_VAR_PLAYER.PlayerMuted = false
		
		local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] unmuted "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."]"
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	end
end
concommand.Add("notsosuper_unmute", notsosuper_CMD_UNMUTE)
lechat.AddCmd("/unmute ", nil, notsosuper_CMD_UNMUTE)
