if (!SERVER) then return end

local function notsosuper_CMD_BURN(ply,cmd,args)
	if (ply:IsValid() && !ply:IsLeader()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
	if not args[1] then notsosuper_MSG_PLY(ply,"You have not entered a player name.") return end
	
	local notsosuper_VAR_PLAYER = NOTSOSUPER_GLB_GETUSER(args[1])
	if notsosuper_VAR_PLAYER == false then NOTSOSUPER_MSG_PLY(ply,"The targeted player could not be found, or there were too many targets.") return end
	
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
	
	if not notsosuper_VAR_PLAYER:Alive() then NOTSOSUPER_MSG_PLY(ply,"The target is not alive.") return end
	
	local notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was set on fire"
	notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
	notsosuper_VAR_PLAYER:Ignite(10)
	
	local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] burned "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."]"
	notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
end
concommand.Add("notsosuper_burn", notsosuper_CMD_BURN)
lechat.AddCmd("/burn ", nil, notsosuper_CMD_BURN)
