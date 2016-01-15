if (!SERVER) then return end

local canspray = {}

function WhenPlayerSprays( ply )
	if not canspray[ply:UniqueID()] then -- create initial player tables
		canspray[ply:UniqueID()] = {}
		canspray[ply:UniqueID()].can = true
		canspray[ply:UniqueID()].disabled = false
		canspray[ply:UniqueID()].ent = nil
	end
	
	local spstart = ply:GetShootPos() -- create local vactor variables
	local sphit = ply:GetEyeTrace().HitPos
	
	if canspray[ply:UniqueID()].disabled then
		return true -- dont spray if they have been naughty
	else	
		local trace = ply:GetEyeTrace()
		net.Start("notsosuper_NET_ADDSPRAY")
			net.WriteEntity(ply)
			net.WriteFloat(trace.HitNormal.x)
			net.WriteFloat(trace.HitNormal.y)
			net.WriteFloat(trace.HitNormal.z)
			net.WriteFloat(trace.HitPos.x)
			net.WriteFloat(trace.HitPos.y)
			net.WriteFloat(trace.HitPos.z)
		net.Broadcast()
	end
	
	if not canspray[ply:UniqueID()].can then
		return true -- dont spray if they arnt allowed too
	end
	
	if spstart:Distance( sphit ) >= 100 then -- if spray distance greater than 100 dont spray
		return true
	end
	
	if canspray[ply:UniqueID()].ent and canspray[ply:UniqueID()].ent:IsValid() then
		canspray[ply:UniqueID()].ent:Remove() -- if player sprayed before, delete their tracking ent
	end
	
	canspray[ply:UniqueID()].ent = ents.Create( "base_point" ) -- create spray ent
	canspray[ply:UniqueID()].ent:SetPos( sphit ) -- set pos to actual spray
	local Ang = ply:GetEyeTrace().HitNormal:Angle()
	Ang = Ang + Angle(180,0,0)
	canspray[ply:UniqueID()].ent:SetAngles( Ang )
	canspray[ply:UniqueID()].ent.name = ply:Nick() -- set spray to players name
	canspray[ply:UniqueID()].ent.uuuuuid = ply:UniqueID() -- set spray to players name
	canspray[ply:UniqueID()].can = false -- player cant spray
	
	timer.Simple(60, AllowUserToSpray, ply)
	
	return false -- allow player to spray
end
hook.Add( "PlayerSpray", "WhenPlayerSprays", WhenPlayerSprays )

function AllowUserToSpray(ply)
	if IsValid(ply) then
		canspray[ply:UniqueID()].can = true
	end
end

function notsosuper_CMD_SPRAYTRACE(ply,cmd)
	if ply and type(ply) != "string" and ply:IsPlayer() then
		if not ply:IsAdmin() then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
		
		local sphit = ply:GetEyeTrace().HitPos
		for k, v in pairs( ents.FindInSphere( sphit, 10 ) ) do
			if v and v:GetClass() == "base_point" then
				notsosuper_MSG_PLY(ply,"Sprayed by: "..v.name )
				return
			end
		end
		notsosuper_MSG_PLY(ply,"No spray was found where you are looking.")
	end
end
concommand.Add("notsosuper_spraytrace", notsosuper_CMD_SPRAYTRACE)
lechat.AddCmd("/spraytrace", nil, notsosuper_CMD_SPRAYTRACE)

local coveredsprays = {}

function notsosuper_CMD_REMOVESPRAY(ply,cmd)
	if ply and type(ply) != "string" and ply:IsPlayer() then
		if not ply:IsAdmin() then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
		local sphit = ply:GetEyeTrace().HitPos
		for k, v in pairs( ents.FindInSphere( sphit, 10 ) ) do
			if v and v:GetClass() == "base_point" then
				local data = {v:GetPos(),v:GetAngles()}
				table.insert(coveredsprays,data)
				for k,v in pairs(player.GetAll()) do
					if(v.gotnet) then
						net.Start("CoverSpray")
						net.WriteTable(data)
						net.Send(v)
					end
				end
				canspray[v.uuuuuid].disabled = true
				local notsosuper_VAR_MESSAGE = v.name.." spray was removed"
				local notsosuper_VAR_ADMINNAME = ply:Nick()
				local notsosuper_VAR_ADMINID = ply:SteamID()
				notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
				
				local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] removed spray by "..v.name
				notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
				return
			end
		end
		notsosuper_MSG_PLY(ply,"No spray was found where you are looking.")
	end
end
concommand.Add("notsosuper_removespray", notsosuper_CMD_REMOVESPRAY)
lechat.AddCmd("/removespray", nil, notsosuper_CMD_REMOVESPRAY)

function InitalSpawnCover(ply)
	if(table.Count(coveredsprays) > 0) then
		net.Start("CoveredSprays")
		net.WriteTable(coveredsprays)
		net.Send(ply)
	end
	ply.gotnet = true
end
hook.Add( "PlayerInitialSpawn", "InitalSpawnCover", InitalSpawnCover )

util.AddNetworkString("CoveredSprays")
util.AddNetworkString("CoverSpray")

function PrepSpray()
	for _,ply in pairs(player.GetAll()) do
		if not canspray[ply:UniqueID()] then -- create initial player tables
			canspray[ply:UniqueID()] = {}
			canspray[ply:UniqueID()].can = true
			canspray[ply:UniqueID()].ent = nil
			canspray[ply:UniqueID()].disabled = false
		else
			canspray[ply:UniqueID()].can = true
			if(canspray[ply:UniqueID()].ent && canspray[ply:UniqueID()].ent:IsValid()) then
				canspray[ply:UniqueID()].ent:Remove()
			end
			canspray[ply:UniqueID()].ent = nil
		end
	end
	net.Start("CoveredSprays")
	local blank = {}
	net.WriteTable(blank)
	net.Broadcast()
end
hook.Add("TTTPrepareRound", "PrepSpray", PrepSpray)
