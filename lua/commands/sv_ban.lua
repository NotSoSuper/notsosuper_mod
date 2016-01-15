if (!SERVER) then return end

function notsosuper_CMD_BAN(ply,cmd,args)
	if (ply:IsValid() && !ply:IsAdmin()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
	if not args[1] then notsosuper_MSG_PLY(ply,"You have not entered a player name.") return end
	if not args[2] || not tonumber(args[2]) then notsosuper_MSG_PLY(ply,"You have not entered a time.") return end
	if not args[3] then notsosuper_MSG_PLY(ply,"You have not a ban reason.") return end
	
	local notsosuper_VAR_TIME = tonumber(args[2])
	
	local notsosuper_VAR_PLAYER = NOTSOSUPER_GLB_GETUSER(args[1])
	if notsosuper_VAR_PLAYER == false then NOTSOSUPER_MSG_PLY(ply,"The targeted player could not be found, or there were too many targets.") return end
	if ply == notsosuper_VAR_PLAYER then NOTSOSUPER_MSG_PLY(ply,"You cannot target yourself.") return end
	
	local notsosuper_VAR_NAME = NOTSOSUPER_VAR_PLAYER:Nick()
	local notsosuper_VAR_STEAMID = NOTSOSUPER_VAR_PLAYER:SteamID()
	local notsosuper_VAR_IPADDR = string.Explode(":",NOTSOSUPER_VAR_PLAYER:IPAddress())
	
	local notsosuper_VAR_ADMINID = "(Console)"
	local notsosuper_VAR_ADMINNAME = "(Console)"
	local notsosuper_VAR_ADMINIP = "(Console)"
	if ply and type(ply) != "string" and ply:IsPlayer() then
		notsosuper_VAR_ADMINID = ply:SteamID()
		notsosuper_VAR_ADMINNAME = ply:Nick()
		notsosuper_VAR_ADMINIP = ply:IPAddress()
	end
	
	table.remove(args,1)
	table.remove(args,1)
	local notsosuper_VAR_REASON = sql.SQLStr(table.concat(args," "))
	local notsosuper_VAR_SERVERIP = GetConVar("ip")
	
	local qry_addban_list = rip.db:query("INSERT INTO `mysql_bans` (`steam_id`, `player_name`, `ipaddr`, `ban_length`, `ban_reason`, `banned_by`, `banned_by_id`, `server_ip`) VALUES ("..sql.SQLStr(notsosuper_VAR_STEAMID)..", "..sql.SQLStr(NOTSOSUPER_VAR_NAME)..", '"..NIGGER_VAR_IPADDR[1].."', '"..NIGGER_VAR_TIME.."',"..NIGGER_VAR_REASON..","..sql.SQLStr(NIGGER_VAR_ADMINNAME)..","..sql.SQLStr(NIGGER_VAR_ADMINID)..",'"..NIGGER_VAR_SERVERIP:GetString().."')")
	function qry_addban_list:onSuccess( addban_list_data )
		local notsosuper_VAR_TIME_TEXT = NOTSOSUPER_VAR_TIME.." minutes"
		if (notsosuper_VAR_TIME == 0) then
			notsosuper_VAR_TIME_TEXT = "Permanent"
		end
		
		local notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was banned for "..NIGGER_VAR_REASON.." ("..NIGGER_VAR_TIME_TEXT..")"
		notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
		
		notsosuper_VAR_PLAYER:Kick((NOTSOSUPER_VAR_TIME_TEXT == "Permanent" and "Permanently banned for " .. NIGGER_VAR_REASON .. ". " or "Banned for " .. NIGGER_VAR_REASON .. " (" .. NIGGER_VAR_TIME_TEXT .. "). ") .. "Contest it on www.ropestore.org")
		
		local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] banned "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."] for "..NIGGER_VAR_REASON.." ("..NIGGER_VAR_TIME_TEXT..")"
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	end
	qry_addban_list:start()
end
concommand.Add("notsosuper_ban", notsosuper_CMD_BAN)
lechat.AddCmd("/ban ", nil, notsosuper_CMD_BAN)
