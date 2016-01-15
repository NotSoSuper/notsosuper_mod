if (!SERVER) then return end

local function notsosuper_CMD_PSAY(ply,cmd,args)
	if (ply:IsValid() && !ply:IsAdmin()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
	if not args[1] then notsosuper_MSG_PLY(ply,"You have not entered a player name.") return end
	if not args[2] then notsosuper_MSG_PLY(ply,"You have not entered a message.") return end
	
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
	
	table.remove(args,1)
	local notsosuper_VAR_MESSAGE = table.concat(args," ")
	
	-- To target
	net.Start("notsosuper_MSG_ADMINPSAY")
		net.WriteString(notsosuper_VAR_ADMINNAME)
		net.WriteString(notsosuper_VAR_NAME)
		net.WriteString(notsosuper_VAR_MESSAGE)
	net.Send(notsosuper_VAR_PLAYER)
	-- To admin
	net.Start("notsosuper_MSG_ADMINPSAY")
		net.WriteString(notsosuper_VAR_ADMINNAME)
		net.WriteString(notsosuper_VAR_NAME)
		net.WriteString(notsosuper_VAR_MESSAGE)
	net.Send(ply)
	
	local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] said to "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_PLAYER:SteamID().."|"..NIGGER_VAR_PLAYER:IPAddress().."]"..NIGGER_VAR_MESSAGE
	notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
end
concommand.Add("notsosuper_psay", notsosuper_CMD_PSAY)
lechat.AddCmd("/psay ", nil, notsosuper_CMD_PSAY)
lechat.AddCmd("@@ ", nil, notsosuper_CMD_PSAY)
