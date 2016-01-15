if (!SERVER) then return end

local function GetPrintFn(ply)
   if IsValid(ply) then
      return function(...)
                local t = ""
                for _, a in ipairs({...}) do
                   t = t .. "\t" .. a
                end
                ply:PrintMessage(HUD_PRINTCONSOLE, t)
             end
   else
      return print
   end
end

local function notsosuper_CMD_LOG(ply,cmd,args)
	if (ply:IsValid() && !ply:IsAdmin()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
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
	
	local notsosuper_VAR_MESSAGE = " used notsosuper_log on "..NOTSOSUPER_VAR_NAME
	notsosuper_MSG_ADMINS(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
	
	local pr = GetPrintFn(ply)
	
	pr("*** Damage log:\n")
	
	for k, txt in ipairs(GAMEMODE.DamageLog) do
		if(notsosuper_VAR_PLAYER) then
			if(string.find(string.lower(txt),string.lower(notsosuper_VAR_NAME))) then
				pr(txt)
			end
		else
			pr(txt)
		end
	end
	
	pr("*** Damage log end.")
	ply:PrintMessage(HUD_PRINTTALK, "Logs have been printed in console")
	
	local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] used notsosuper_log on "..NIGGER_VAR_NAME
	notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
end
concommand.Add("notsosuper_log", notsosuper_CMD_LOG)
lechat.AddCmd("/log ", nil, notsosuper_CMD_LOG)
