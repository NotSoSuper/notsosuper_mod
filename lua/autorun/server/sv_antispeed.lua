if not SERVER then return end

util.AddNetworkString("notsosuper_MSG_ASH")
util.AddNetworkString("notsosuper_MSG_SCH")
util.AddNetworkString("notsosuper_MSG_RCH")

net.Receive("notsosuper_MSG_ASH",function(l,ply)
	timer.Simple(5, function()
		if ply then
			game.ConsoleCommand("notsosuper_ban \""..ply:SteamID().."\" 0 [notsosuper] Speed Hack Detected \n")
		end
	end)
end)

net.Receive("notsosuper_MSG_SCH",function(l,ply)
	local SCH = net.ReadString()
	if ply then
		local notsosuper_LOG_MESSAGE = ply:Nick().." ["..ply:SteamID().."] detected speed hack [SCH] "..SCH
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	end
end)

net.Receive("notsosuper_MSG_RCH",function(l,ply)
	local RCH = net.ReadString()
	if ply then
		local notsosuper_LOG_MESSAGE = ply:Nick().." ["..ply:SteamID().."] detected speed hack [RCH] "..RCH
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	end
end)
