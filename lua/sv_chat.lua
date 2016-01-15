if (!SERVER) then return end

chat = { }
	
function chat.AddText( ... )
	local arg = {...}
	if ( type( arg[1] ) == "Player" ) then ply = arg[1] table.remove(arg,1) end
	table.insert(arg,1,Color(255,255,255))
	net.Start("AddText")
		net.WriteTable(arg)
	if(ply) then
		net.Send(ply)
	else
		net.Broadcast()
	end
end

notsosuper_GLB_LOG = {}
lechat = {}
local commandsChat = {}

local ads = {}
ads[1] = {Color(255, 255, 255),"We are recruiting, ",Color(100, 220, 80),"apply at www.ropestore.org"}
ads[2] = 1337
ads[3] = {Color(255, 255, 255),"Admin is ",Color(100, 220, 80),"FREE",Color(255, 255, 255),"! Visit www.ropestore.org"}
ads[4] = {Color(255, 255, 255),"Join us on TeamSpeak @ ",Color(100, 220, 80),"voice.ropestore.org:4501"}
ads[5] = {Color(255, 255, 255),"Bored? Try out our other servers, type ",Color(100, 220, 80),"!motd"}
ads[6] = {Color(255, 255, 255),"Follow our",Color(100, 220, 80)," !rules ",Color(255, 255, 255),"at all times."}

local adn = 1

function notsosuper_GLB_PRINTAD()
	ad = ads[adn]
	if(type(ad) == "number" && ad == 1337) then
		ads[adn] = {Color(255, 255, 255),"Like this server? Add it to your favorites: " ,Color(100, 220, 80)," "..GetConVarString("ip")..":27015"}
	end
	for k,v in pairs(player.GetAll()) do
		chat.AddText(v, unpack(ads[adn]))
	end
	adn = adn + 1
	if(adn > #ads) then
		adn = 1
	end
end

timer.Create("NotSoSuperAds", 45, 0, notsosuper_GLB_PRINTAD)

function notsosuper_GLB_LOG.Time( seconds, Format )
    if not seconds then seconds = 0 end
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds / 60) % 60)
    local millisecs = ( seconds - math.floor( seconds ) ) * 100
    seconds = seconds % 60
    
    return string.format( Format, hours, minutes )
end

function notsosuper_GLB_LOG.AddLogLine(line)
	local datet = {}
	datet = os.date("*t")
	local daystart = {}
	daystart = datet
	daystart.min = 0
	daystart.hour = 0
	daystart.sec = 0
	local beggining = os.difftime(os.time(),os.time(daystart))
	local datestring = datet.day.."-"..datet.month.."-"..string.sub(datet.year, 3, 4)
	line = notsosuper_GLB_LOG.Time(beggining, "[%02i:%02i] ") .. line
	if(!file.Exists("logs/"..datestring..".txt","DATA")) then
		file.Write("logs/"..datestring..".txt",datestring.." LOG-START\n")
	end
	local f = file.Open( "logs/"..datestring..".txt", "a", "DATA" )
	if ( !f ) then return end
	f:Write( line.."\n" )
	f:Close()
end

function notsosuper_GLB_LOG.AddChatToLog(ply,text,team)
	local plystring = string.sub(ply:Nick(),1,25).." ["..ply:SteamID().."]"
	if(team) then
		notsosuper_GLB_LOG.AddLogLine(plystring.." said to his team: "..text)
	else
		notsosuper_GLB_LOG.AddLogLine(plystring.." said: "..text)
	end
end

function notsosuper_GLB_ChatChecks( ply, text, public )
	if(string.sub(text, 1, 1) == "@" && string.sub(text, 1, 2) != "@@") then
		local thetext = string.sub( text, 2 )
		if(ply:IsAdmin()) then
			if(!public) then
				ply:ConCommand("notsosuper_say "..thetext)
				return false
			else
				ply:ConCommand("notsosuper_chat "..thetext)
				return false
			end
		else
			ply:ConCommand("notsosuper_chat "..thetext)
			return false
		end
	end
	for k,v in pairs(commandsChat) do
		if(string.sub(text,1,string.len(v.Name)) == v.Name) then
			if((v.Team && v.Team == public) || (v.Team == nil)) then
				local args = string.Explode(" ", text)
				if(#args ~= 1) then
					table.remove(args, 1)
					v.Function(ply,string.gsub(string.sub(text,1,string.len(v.Name)),"/","notsosuper_"),args)
					return false
				else
					v.Function(ply,string.gsub(string.sub(text,1,string.len(v.Name)),"/","notsosuper_"),nil)
					return false
				end
			end
		end
	end
	notsosuper_GLB_LOG.AddChatToLog(ply,text,public)
end
hook.Add( "PlayerSay", "notsosuper_GLB_ChatChecks", NOTSOSUPER_GLB_ChatChecks )

function lechat.AddCmd(text,team,func)
	table.insert(commandsChat,{Name = text, Team = team, Function = func})
end

function notsosuper_MSG_PLY(ply,msg)
	if not ply:IsValid() then return end
	net.Start("notsosuper_MSG_PLY")
		net.WriteString(ply:Nick())
		net.WriteString(msg)
	net.Send(ply)
end

function notsosuper_MSG_ALL(admin,action)
	net.Start("notsosuper_MSG_ALL")
		net.WriteString(action)
		net.WriteString(admin)
	net.Broadcast()
end

function notsosuper_MSG_ADMINS(admin,action)
	net.Start("notsosuper_MSG_ADMINS")
		net.WriteString(action)
		net.WriteString(admin)
	net.Broadcast()
end

function ShowKiller(victim, attacker)
	local role = attacker.GetRole and attacker:GetRole() or ROLE_INNOCENT
	if attacker:IsPlayer() && (role == ROLE_INNOCENT || role == ROLE_DETECTIVE) then
        victim:PrintMessage(HUD_PRINTTALK, "You have been killed by an innocent.")
    elseif attacker:IsPlayer() && role == ROLE_TRAITOR then
        victim:PrintMessage(HUD_PRINTTALK, "You have been killed by a traitor.")
	elseif not attacker:IsPlayer() then
		victim:PrintMessage(HUD_PRINTTALK, "You were not killed by a player.")
	end
end

hook.Add("Initialize","AdFix",function()
	if gamemode.Get("terrortown") then
		hook.Add("DoPlayerDeath", "ShowKiller", ShowKiller)
	end
end)
