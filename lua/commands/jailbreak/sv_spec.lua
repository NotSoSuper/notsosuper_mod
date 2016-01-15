if (!SERVER) then return end

function notsosuper_CMD_SPEC(ply,cmd,args)
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
	
	if(notsosuper_VAR_PLAYER:Team() != TEAM_SPECTATOR) then
		local notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was moved to spectator"
		notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
		
		if (!notsosuper_VAR_PLAYER:NotAlive()) then
			notsosuper_VAR_PLAYER:StripWeapons()
			notsosuper_VAR_PLAYER:Kill()
		end
		
		notsosuper_VAR_PLAYER:SetTeam(TEAM_SPECTATOR)
		
		local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] moved "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."] to spectator."
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	else
		notsosuper_MSG_PLY(ply,"The target is already a spectator.")
	end
end
concommand.Add("notsosuper_spec",notsosuper_CMD_SPEC)
lechat.AddCmd("/spec ", nil,notsosuper_CMD_SPEC)
