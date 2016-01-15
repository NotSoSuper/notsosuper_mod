if (!SERVER) then return end

local function notsosuper_CMD_MOTD(ply,cmd)
	if ply and type(ply) != "string" and ply:IsPlayer() then
		ply:ConCommand("motd")
	end
end
concommand.Add("notsosuper_motd", notsosuper_CMD_MOTD)
lechat.AddCmd("/motd", nil, notsosuper_CMD_MOTD)
lechat.AddCmd("!motd", nil, notsosuper_CMD_MOTD)
lechat.AddCmd("!rules", nil, notsosuper_CMD_MOTD)
hook.Add("PlayerInitialSpawn", "notsosuper_CMD_MOTD", NOTSOSUPER_CMD_MOTD)
