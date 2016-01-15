if (!SERVER) then return end

function notsosuper_CMD_SWAPTEAM(ply,cmd,args)
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
	
	local notsosuper_VAR_MESSAGE
	local notsosuper_LOG_MESSAGE
	
	if(!notsosuper_VAR_PLAYER:NotAlive() && NOTSOSUPER_VAR_PLAYER:Team() == TEAM_GUARD) then
		notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was team swapped from Guard to Prisoner."
		notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
		
		notsosuper_VAR_PLAYER:StripWeapons()
		notsosuper_VAR_PLAYER:SetTeam(TEAM_PRISONER)
		notsosuper_VAR_PLAYER:Kill()
		
		notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] team swapped "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."] from Guard to Prisoner."
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	elseif(!notsosuper_VAR_PLAYER:NotAlive() && NOTSOSUPER_VAR_PLAYER:Team() == TEAM_PRISONER) then
		notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was team swapped from Prisoner to Guard."
		notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
		
		notsosuper_VAR_PLAYER:StripWeapons()
		notsosuper_VAR_PLAYER:SetTeam(TEAM_GUARD)
		notsosuper_VAR_PLAYER:Kill()
		
		notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] team swapped "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."] from Prisoner to Guard."
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	elseif(notsosuper_VAR_PLAYER:Team() == TEAM_PRISONER_DEAD) then
		notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was team swapped from Prisoner to Guard."
		notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
		
		notsosuper_VAR_PLAYER:SetTeam(TEAM_GUARD_DEAD)
		
		notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] team swapped "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."] from Prisoner to Guard."
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	elseif(notsosuper_VAR_PLAYER:Team() == TEAM_GUARD_DEAD) then
		notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was team swapped from Guard to Prisoner."
		notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
		
		notsosuper_VAR_PLAYER:SetTeam(TEAM_PRISONER_DEAD)
		
		notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] team swapped "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."] from Guard to Prisoner."
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	else notsosuper_MSG_PLY(ply,"The targeted player is in spectator.") return end
end
concommand.Add("notsosuper_swapteam",notsosuper_CMD_SWAPTEAM)
lechat.AddCmd("/swapteam ", nil,notsosuper_CMD_SWAPTEAM)
