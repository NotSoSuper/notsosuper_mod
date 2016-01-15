if (!SERVER) then return end

local function notsosuper_CMD_GAG(ply,cmd,args)
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
	
	if not notsosuper_VAR_PLAYER.PlayerGagged then
		local notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was gagged"
		notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
		notsosuper_VAR_PLAYER.PlayerGagged = true
		
		local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] gagged "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."]"
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	end
end
concommand.Add("notsosuper_gag", notsosuper_CMD_GAG)
lechat.AddCmd("/gag ", nil, notsosuper_CMD_GAG)

local function notsosuper_CMD_UNGAG(ply,cmd,args)
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
	
	if notsosuper_VAR_PLAYER.PlayerGagged then
		local notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was ungagged"
		notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
		notsosuper_VAR_PLAYER.PlayerGagged = false
		
		local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] ungagged "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."]"
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	end
end
concommand.Add("notsosuper_ungag", notsosuper_CMD_UNGAG)
lechat.AddCmd("/ungag ", nil, notsosuper_CMD_UNGAG)

hook.Add("PlayerSay", "PlayerSay_notsosuper_HOOK_GAG", function(ply, msg)
	if ply.PlayerGagged then return "" end
end)
