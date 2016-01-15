if (!SERVER) then return end

local function notsosuper_CMD_SCREENSHOT(ply,cmd,args)
	if (!ply and type(ply) == "string" and !ply:IsPlayer()) then notsosuper_MSG_PLY(ply,"You cannot use this via console.") return end
	if (!ply:IsAdmin()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
	if not args[1] then notsosuper_MSG_PLY(ply,"You have not entered a player name.") return end
	
	local notsosuper_VAR_PLAYER = NOTSOSUPER_GLB_GETUSER(args[1])
	if notsosuper_VAR_PLAYER == false then NOTSOSUPER_MSG_PLY(ply,"The targeted player could not be found, or there were too many targets.") return end
	if ply == notsosuper_VAR_PLAYER then NOTSOSUPER_MSG_PLY(ply,"You cannot target yourself.") return end
	
	local notsosuper_VAR_NAME = NOTSOSUPER_VAR_PLAYER:Nick()
	local notsosuper_VAR_STEAMID = NOTSOSUPER_VAR_PLAYER:SteamID()
	
	local notsosuper_VAR_ADMINID = ply:SteamID()
	local notsosuper_VAR_ADMINNAME = ply:Nick()
	local notsosuper_VAR_ADMINIP = ply:IPAddress()
	
	local notsosuper_VAR_MESSAGE = " has taken a screenshot of "..NOTSOSUPER_VAR_NAME
	notsosuper_MSG_ADMINS(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
	
	net.Start("notsosuper_NET_REQUESTSCREEN")
	net.WriteEntity(ply)
	net.Send(notsosuper_VAR_PLAYER)
	
	notsosuper_MSG_PLY(ply,"Screenshot requested - please wait for it to be loaded.")
	
	local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] has taken a screenshot of "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."]"
	notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
end
concommand.Add("notsosuper_screenshot", notsosuper_CMD_SCREENSHOT)
lechat.AddCmd("/screenshot ", nil, notsosuper_CMD_SCREENSHOT)
