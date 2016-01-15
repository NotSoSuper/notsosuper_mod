if (!SERVER) then return end

function notsosuper_CMD_UP(ply,cmd,args)
	if (ply:IsValid() and ply:GetUserGroup() != "recruit" and ply:GetUserGroup() != "junior" and !ply:IsAdmin()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
	if not args[1] then notsosuper_MSG_PLY(ply,"You have not entered a player name.") return end
	if not args[2] then notsosuper_MSG_PLY(ply,"You have not entered a message to your review.") return end
	
	local notsosuper_VAR_PLAYER = NOTSOSUPER_GLB_GETUSER(args[1])
	if notsosuper_VAR_PLAYER == false then NOTSOSUPER_MSG_PLY(ply,"The targeted player could not be found, or there were too many targets.") return end
	if ply == notsosuper_VAR_PLAYER then NOTSOSUPER_MSG_PLY(ply,"You cannot target yourself.") return end
	if (notsosuper_VAR_PLAYER:GetUserGroup() != "recruit" and NOTSOSUPER_VAR_PLAYER:GetUserGroup() != "junior" and NIGGER_VAR_PLAYER:GetUserGroup() != "junior-admin") then NIGGER_MSG_PLY(ply,"You cannot target this player.") return end
	
	local notsosuper_VAR_NAME = NOTSOSUPER_VAR_PLAYER:Nick()
	local notsosuper_VAR_STEAMID = NOTSOSUPER_VAR_PLAYER:SteamID()
	local notsosuper_VAR_IPADDR = string.Explode(":",NOTSOSUPER_VAR_PLAYER:IPAddress())
	
	local notsosuper_VAR_ADMINID = "(Console)"
	local notsosuper_VAR_ADMINNAME = "(Console)"
	if ply and type(ply) != "string" and ply:IsPlayer() then
		notsosuper_VAR_ADMINID = ply:SteamID()
		notsosuper_VAR_ADMINNAME = ply:Nick()
	end
	
	table.remove(args,1)
	local notsosuper_VAR_REASON = sql.SQLStr(table.concat(args," "))
	
	local qry_select_review = rip.db:query("SELECT `id` FROM `pg_reputation` WHERE `timestamp` > (NOW() - INTERVAL 24 HOUR) AND `to_steamid` LIKE '%"..notsosuper_VAR_STEAMID.."%' AND `from_steamid` LIKE '%"..NOTSOSUPER_VAR_ADMINID.."%'")
	function qry_select_review:onSuccess( qry_data_review )
		if (qry_data_review[1]) then
			notsosuper_MSG_PLY(ply,"You can only write 1 review on the notsosupere person once every 24 hours.")
			notsosuper_MSG_PLY(ply,"If you wish to edit your previous review, go to their forum profile.")
		else
			local qry_insert_review = rip.db:query("INSERT INTO `pg_reputation` (`to_steamid`, `from_steamid`, `type`, `note`) VALUES ('"..notsosuper_VAR_STEAMID.."', '"..NOTSOSUPER_VAR_ADMINID.."', '1', "..sql.SQLStr(NIGGER_VAR_REASON)..")")
			function qry_insert_review:onSuccess( qry_data_insert )
				notsosuper_MSG_PLY(ply,"Your review has been saved.")
			end
			qry_insert_review:start()
		end
	end
	qry_select_review:start()
end
concommand.Add("notsosuper_up", notsosuper_CMD_UP)
lechat.AddCmd("/up ", nil, notsosuper_CMD_UP)
