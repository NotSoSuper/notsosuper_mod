if (!SERVER) then return end

------ Trouble in Terrorist Town
--include('commands/terrortown/sv_log.lua')
------ Bunny Hop & Surf
--include('commands/bunnyhop/sv_unstuck.lua')
------ Jail Break
--include('commands/jailbreak/sv_guardban.lua')
--include('commands/jailbreak/sv_spec.lua')
--include('commands/jailbreak/sv_swapteam.lua')
--include('commands/jailbreak/sv_firewarden.lua')
--include('commands/jailbreak/sv_log.lua')

rip = {}

local STEAM_API_KEY = ""
local DATABASE_HOST = "ropestore.org"
local DATABASE_PORT = 3306
local DATABASE_NAME = ""
local DATABASE_USERNAME = ""
local DATABASE_PASSWORD = ""

local function rip_ConnectToDatabase()
	rip.db = mysqloo.connect( DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME, DATABASE_PORT)
	rip.db:connect()
end
hook.Add( "Initialize", "rip_ConnectToDatabase", PGSQL_ConnectToDatabase )

function notsosuper_NAMECHECK()
	if rip.db:status() != 0 then return end
	
	local players = player.GetAll()
	for _, ply in ipairs( players ) do
		if not ply.notsosuper_VAR_LASTKNOWNNAME then ply.NOTSOSUPER_VAR_LASTKNOWNNAME = ply:Nick() end
		if ply.notsosuper_VAR_LASTKNOWNNAME ~= ply:Nick() then
			ply.notsosuper_VAR_LASTKNOWNNAME = ply:Nick()
			notsosuper_CHECKTAGS(ply)
		end
	end
end
timer.Create("notsosuper_NAMECHECK", 5, 0, NOTSOSUPER_NAMECHECK)

function notsosuper_CHECKNAME(ply)
	if rip.db:status() != 0 then return end
	
	if ply.notsosuper_RANK_NAME == nil then return end
	local notsosuper_VAR_USERGROUP = ply:IsRank()
	if notsosuper_VAR_USERGROUP == "" then return end
	
	local notsosuper_VAR_PLYCHARS = string.len(ply.NOTSOSUPER_RANK_NAME) --correct
	local notsosuper_VAR_TAGCHARS = string.len(NOTSOSUPER_VAR_USERGROUP) -- correct
	
	if (string.Left(ply:Nick(), 10) == notsosuper_VAR_USERGROUP.." ") then NOTSOSUPER_VAR_TAGCHARS = 11
	elseif (string.Left(ply:Nick(), 5) == notsosuper_VAR_USERGROUP.." ") then NOTSOSUPER_VAR_TAGCHARS = 6
	else notsosuper_VAR_TAGCHARS = NOTSOSUPER_VAR_TAGCHARS + 1 end
	
	if not (string.lower(string.Left(string.sub(ply:Nick(),notsosuper_VAR_TAGCHARS), NOTSOSUPER_VAR_PLYCHARS)) == string.lower(ply.NIGGER_RANK_NAME)) then
		ply.notsosuper_VAR_LASTKNOWNNAME = "Ls2hbG"
		if ply.notsosuper_NAMEWARNINGS == nil then ply.NOTSOSUPER_NAMEWARNINGS = 0 end
		ply.notsosuper_NAMEWARNINGS = ply.NOTSOSUPER_NAMEWARNINGS + 1
		if ply.notsosuper_NAMEWARNINGS >= 30 then ply:Kick("Change Your Core Name to ("..ply.NOTSOSUPER_RANK_NAME..")")
		else notsosuper_MSG_PLY(ply,"Change your core name ("..string.Left(string.sub(ply:Nick(),NOTSOSUPER_VAR_TAGCHARS), NIGGER_VAR_PLYCHARS)..") to match your forum name ("..ply.NIGGER_RANK_NAME..") or you will be auto-kicked.") end
	end
end

function notsosuper_CHECKTAGS(ply)
	if rip.db:status() != 0 then return end
	
	local notsosuper_VAR_USERGROUP = ply:IsRank()
	
	if notsosuper_VAR_USERGROUP == "" then
		if (string.Left(ply:Nick(), 4) == "[NotSoSuper]" || string.Left(ply:Nick(), 6) == "=[Nigger]=") then ply:Kick("Remove the Nigger Gaming Tags") end
	else
		if ply.notsosuper_TAGWARNINGS == nil then ply.NOTSOSUPER_TAGWARNINGS = 0 end
		if (string.Left(ply:Nick(), string.len(notsosuper_VAR_USERGROUP)) != NOTSOSUPER_VAR_USERGROUP) then
			ply.notsosuper_VAR_LASTKNOWNNAME = "Ls2hbG"
			ply.notsosuper_TAGWARNINGS = ply.NOTSOSUPER_TAGWARNINGS + 1
			if ply.notsosuper_TAGWARNINGS >= 30 then ply:Kick("Put on your "..NOTSOSUPER_VAR_USERGROUP.." tags")
			else notsosuper_MSG_PLY(ply,"Please put on your "..NOTSOSUPER_VAR_USERGROUP.." tags or you will be auto-kicked") end
		else notsosuper_CHECKNAME(ply) end
	end
end

local function notsosuper_CHECKRANK(ply)
	local notsosuper_LOG_MESSAGE = ply:Nick().." ["..ply:SteamID().."|"..ply:IPAddress().."] has connected."
	notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	if (ply.CheckedPlayerRank) then
		local qry_admin_list = rip.db:query("SELECT id, name FROM notsosuper_admins WHERE identity = '"..ply:SteamID().."'")
			function qry_admin_list:onSuccess( admin_list_data )
				if (admin_list_data[1]) then
					ply.notsosuper_RANK_NAME = admin_list_data[1]["name"]
					admin_id = admin_list_data[1]["id"]
					local qry_admin_group = rip.db:query("SELECT group_id FROM notsosuper_admins_groups WHERE admin_id = '"..admin_id.."'")
						function qry_admin_group:onSuccess( admin_group_data )
							if (admin_group_data[1]) then
								for k, v in pairs(admin_group_data) do
									group_id = tonumber(v["group_id"])
									if (group_id == 4 || group_id == 2 || group_id == 25) then ply:SetNetVar("notsosuper_NET_VIP", true)
									elseif (group_id == 10) then ply.notsosuper_ADMIN_CUSTOM_1 = true end
									if (group_id == 12) then ply:SetUserGroup("recruit", true)	notsosuper_CHECKTAGS(ply)
									elseif (group_id == 13) then ply:SetUserGroup("junior", true)	notsosuper_CHECKTAGS(ply)
									elseif (group_id == 14) then ply:SetUserGroup("member", true)	notsosuper_CHECKTAGS(ply)
									elseif (group_id == 3) then ply:SetUserGroup("advisor", true)	notsosuper_CHECKTAGS(ply)
									elseif (group_id == 9) then ply:SetUserGroup("divmgr", true)	notsosuper_CHECKTAGS(ply)
									elseif (group_id == 6) then ply:SetUserGroup("council", true)	notsosuper_CHECKTAGS(ply)
									elseif (gamemode.Get("terrortown") || gamemode.Get("jailbreak")) then
										if (ply.notsosuper_ADMIN_CUSTOM_1 && group_id == 21) then ply:SetUserGroup("junior-admin", true)	NOTSOSUPER_CHECKTAGS(ply)
										elseif (ply.notsosuper_ADMIN_CUSTOM_1 && group_id == 20) then ply:SetUserGroup("member-admin", true)	NOTSOSUPER_CHECKTAGS(ply)	end
									else
										if (group_id == 21) then ply:SetUserGroup("junior-admin", true)	notsosuper_CHECKTAGS(ply)
										elseif (group_id == 20) then ply:SetUserGroup("member-admin", true)	notsosuper_CHECKTAGS(ply)	end
									end
								end
							end
						end
					qry_admin_group:start()
				end
			end
		qry_admin_list:start()
		ply.CheckedPlayerRank = false
	chat.AddText(Color(255, 255, 255), ply:Nick().." [", Color(161, 255, 161), ply:SteamID(), Color(255, 255, 255),"] connected.")
	end
end

local function notsosuper_CHECKBAN(ply)
	-- Ban system
		-- Database Bans
		local bannedipaddress = string.Explode(":",ply:IPAddress())
		local qry_ban_list = rip.db:query("SELECT steam_id, ban_length, ban_reason, ipaddr, round((UNIX_TIMESTAMP(timestamp)+(60*ban_length)-UNIX_TIMESTAMP(now()))/60) AS ban_remaining FROM mysql_bans WHERE `steam_id` = '"..ply:SteamID().."' AND `status` = '0' AND `type` = 'server' OR `steam_id` = '"..ply.lendersteamid.."' AND `status` = '0' AND `type` = 'server' OR `ipaddr` = '"..bannedipaddress[1].."' AND `status` = '0' AND `type` = 'server'")
		function qry_ban_list:onSuccess( ban_list_data )
			if (ban_list_data[1]) then
				for k, v in pairs(ban_list_data) do
					if ply.PlayerBanned then return end
					local ban_ipaddr = v["ipaddr"]
					local bannedsteamid = v["steam_id"]
					local ban_length = v["ban_length"]
					local ban_reason = v["ban_reason"]
					local ban_remaining = tonumber(v["ban_remaining"])
					if (ban_length == 0) then
						ban_remaining = 0
					end
					if (ban_remaining >= 0) then
						ply.PlayerBanned = true
						if ply:SteamID() != bannedsteamid then
							if bannedsteamid == "" then bannedsteamid = ban_ipaddr end
							--if not string.StartWith( ply.bannedsteamid, "STEAM_" ) then ply.bannedsteamid = ban_ipaddr end
							local notsosuper_VAR_NAME = ply:Nick()
							local notsosuper_VAR_SERVERIP = GetConVar("ip")
							local qry_ban_add = rip.db:query("INSERT INTO `mysql_bans` (`steam_id`, `player_name`, `ban_length`, `ban_reason`, `banned_by`, `banned_by_id`, `status_leadership`, `server_ip`, `game`) VALUES ('"..ply:SteamID().."', "..sql.SQLStr(notsosuper_VAR_NAME)..", '0','Ban Evasion ("..bannedsteamid..")','Console','Console','1','"..NOTSOSUPER_VAR_SERVERIP:GetString().."','4')")
							qry_ban_add:start()
						end
						ply.CheckedPlayerRank = false
						local ban_length_text = ban_remaining
						if (ban_length == 0) then
							ban_length_text = "Permanent"
						end
						ply:Kick((ban_length_text == "Permanent" and "Permanently banned for '" .. ban_reason .. "'. " or "Banned for '" .. ban_reason .. "' (" .. ban_length_text .. " minutes remaining). ") .. "Contest it on www.ropestore.org")
						break
					end
				end
				if (ply.CheckedPlayerRank) then
					notsosuper_CHECKRANK(ply)
				end
			else
				notsosuper_CHECKRANK(ply)
			end
		end
		qry_ban_list:start()
	-- End ban system
	return
end

local function rip_PlayerAuthDB( ply )
	dbStatus = rip.db:status();
	if dbStatus == nil || dbStatus != 0 and dbStatus != 1 then rip_ConnectToDatabase() end
	----------------------------
	-- Default Values
	----------------------------
	ply.PlayerBanned = false
	ply.CheckedPlayerRank = true
	-- Commands Dependent Variables
	ply.PlayerGagged = false
	ply.PlayerMuted = false
	ply.PlayerFrozen = false
	ply.PlayerGod = false
	-- Other
	ply.notsosuper_ADMIN_CUSTOM_1 = false
	ply.lendersteamid = "MnHbB6hvgS" -- For Family Sharing
	----------------------------
	if rip.db:status() == 0 then
		-- Steam Family Sharing
		http.Fetch(
			string.format("http://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v0001/?key=%s&format=json&steamid=%s&appid_playing=4000",STEAM_API_KEY,ply:SteamID64()),
			function(body)
				body = util.JSONToTable(body)
				if body and body.response and body.response.lender_steamid then
					local lender = body.response.lender_steamid
					if lender ~= "0" then
						ply.lendersteamid = util.SteamIDFrom64(lender)
						notsosuper_CHECKBAN(ply)
					else
						notsosuper_CHECKBAN(ply)
					end
				else
					notsosuper_CHECKBAN(ply)
				end
			end,
			function(error)
				notsosuper_CHECKBAN(ply)
			end
		)
	end
end
hook.Add( "PlayerAuthed", "rip_PlayerAuthDB", PGSQL_PlayerAuthDB )

function notsosuper_MSG_DISCONNECTED(ply)
	if not ply.PlayerBanned then
		chat.AddText(Color(255, 255, 255), ply:Nick().." [", Color(161, 255, 161), ply:SteamID(), Color(255, 255, 255),"] disconnected.")
	end
end
hook.Add("PlayerDisconnected", "notsosuper_MSG_DISCONNECTED", NOTSOSUPER_MSG_DISCONNECTED)
