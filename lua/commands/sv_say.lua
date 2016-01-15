if (!SERVER) then return end

local function notsosuper_CMD_SAY(ply,cmd,args)
	if (ply:IsValid() && !ply:IsAdmin()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
	if not args[1] then notsosuper_MSG_PLY(ply,"You have not entered a message.") return end
	
	local notsosuper_VAR_ADMINID = "(Console)"
	local notsosuper_VAR_ADMINNAME = "(Console)"
	local notsosuper_VAR_ADMINIP = "(Console)"
	if ply and type(ply) != "string" and ply:IsPlayer() then
		notsosuper_VAR_ADMINID = ply:SteamID()
		notsosuper_VAR_ADMINNAME = ply:Nick()
		notsosuper_VAR_ADMINIP = ply:IPAddress()
	end
	
	local notsosuper_VAR_MESSAGE = table.concat(args," ")
	
	net.Start("notsosuper_MSG_ADMINSAY")
		net.WriteString(notsosuper_VAR_MESSAGE)
		net.WriteString(notsosuper_VAR_ADMINNAME)
	net.Broadcast()
	
	local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] said to everyone: "..NIGGER_VAR_MESSAGE
	notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
end
concommand.Add("notsosuper_say", notsosuper_CMD_SAY)
lechat.AddCmd("/say ", nil, notsosuper_CMD_SAY)
