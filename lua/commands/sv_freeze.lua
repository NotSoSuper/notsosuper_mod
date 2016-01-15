if (!SERVER) then return end

local function notsosuper_CMD_FREEZE(ply,cmd,args)
	if (ply:IsValid() && !ply:IsLeader()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
	if not args[1] then notsosuper_MSG_PLY(ply,"You have not entered a player name.") return end
	
	local notsosuper_VAR_PLAYER = NOTSOSUPER_GLB_GETUSER(args[1])
	if notsosuper_VAR_PLAYER == false then NOTSOSUPER_MSG_PLY(ply,"The targeted player could not be found, or there were too many targets.") return end
	if ply == notsosuper_VAR_PLAYER then NOTSOSUPER_MSG_PLY(ply,"You cannot target yourself.") return end
	
	local notsosuper_VAR_NAME = NOTSOSUPER_VAR_PLAYER:Nick()
	local notsosuper_VAR_STEAMID = NOTSOSUPER_VAR_PLAYER:SteamID()
	local notsosuper_VAR_IP = NOTSOSUPER_VAR_PLAYER:IPAddress()
	
	local notsosuper_VAR_ADMINID = "(Console)"
	local notsosuper_VAR_ADMINNAME = "(Console)"
	local notsosuper_VAR_ADMINIP = "(Console)"
	if ply and type(ply) != "string" and ply:IsPlayer() then
		notsosuper_VAR_ADMINID = ply:SteamID()
		notsosuper_VAR_ADMINNAME = ply:Nick()
		notsosuper_VAR_ADMINIP = ply:IPAddress()
	end
	
	if notsosuper_VAR_PLAYER:InVehicle() then
		notsosuper_VAR_PLAYER:ExitVehicle()
	end
	if not notsosuper_VAR_PLAYER.PlayerFrozen then
		local notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was frozen"
		notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
		notsosuper_VAR_PLAYER:Lock()
		notsosuper_VAR_PLAYER.PlayerFrozen = true
		
		local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] froze "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."]"
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	end
end
concommand.Add("notsosuper_freeze", notsosuper_CMD_FREEZE)
lechat.AddCmd("/freeze ", nil, notsosuper_CMD_FREEZE)

local function notsosuper_CMD_UNFREEZE(ply,cmd,args)
	if (ply:IsValid() && !ply:IsLeader()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
	if not args[1] then notsosuper_MSG_PLY(ply,"You have not entered a player name.") return end
	
	local notsosuper_VAR_PLAYER = NOTSOSUPER_GLB_GETUSER(args[1])
	if notsosuper_VAR_PLAYER == false then NOTSOSUPER_MSG_PLY(ply,"The targeted player could not be found, or there were too many targets.") return end
	if ply == notsosuper_VAR_PLAYER then NOTSOSUPER_MSG_PLY(ply,"You cannot target yourself.") return end
	
	local notsosuper_VAR_NAME = NOTSOSUPER_VAR_PLAYER:Nick()
	local notsosuper_VAR_STEAMID = NOTSOSUPER_VAR_PLAYER:SteamID()
	local notsosuper_VAR_IP = NOTSOSUPER_VAR_PLAYER:IPAddress()
	
	local notsosuper_VAR_ADMINID = "(Console)"
	local notsosuper_VAR_ADMINNAME = "(Console)"
	local notsosuper_VAR_ADMINIP = "(Console)"
	if ply and type(ply) != "string" and ply:IsPlayer() then
		notsosuper_VAR_ADMINID = ply:SteamID()
		notsosuper_VAR_ADMINNAME = ply:Nick()
		notsosuper_VAR_ADMINIP = ply:IPAddress()
	end
	
	if notsosuper_VAR_PLAYER:InVehicle() then
		notsosuper_VAR_PLAYER:ExitVehicle()
	end
	if notsosuper_VAR_PLAYER.PlayerFrozen then
		local notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was unfrozen"
		notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
		notsosuper_VAR_PLAYER:UnLock()
		notsosuper_VAR_PLAYER.PlayerFrozen = false
		
		local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] unfroze "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."]"
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	end
end
concommand.Add("notsosuper_unfreeze", notsosuper_CMD_UNFREEZE)
lechat.AddCmd("/unfreeze ", nil, notsosuper_CMD_UNFREEZE)
