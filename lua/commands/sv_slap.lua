if (!SERVER) then return end

local function notsosuper_CMD_SLAP(ply,cmd,args)
	if (ply:IsValid() && !ply:IsLeader()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
	if not args[1] then notsosuper_MSG_PLY(ply,"You have not entered a player name.") return end
	if not args[2] then notsosuper_MSG_PLY(ply,"You have not entered a direction (up|down|left|right).") return end
	if not args[3] || not tonumber(args[3]) then notsosuper_MSG_PLY(ply,"You have not entered a power/force.") return end
	
	local notsosuper_VAR_DIRECTION = args[2]
	if type(notsosuper_VAR_DIRECTION) != "string" then NOTSOSUPER_MSG_PLY(ply,"You have used an incorrect direction, please use: notsosuper_slap <name> <up|down|left|right> <power>") return end
	
	local notsosuper_VAR_POWER = tonumber(args[3])
	
	local direction = Vector( math.random( 20 )-10, math.random( 20 )-10, math.random( 20 )-5 ) -- Make it random
	
	if notsosuper_VAR_DIRECTION == "up" then
		direction = Vector( math.random( 20 )-10, math.random( 20 )-10, math.random( 20 )-5 ) -- Make it random, slightly biased to go up.
	elseif notsosuper_VAR_DIRECTION == "left" then
		direction = Vector( math.random( 20 )-10, math.random( 20 )-10, math.random( 20 )-5 ) -- Make it random, slightly biased to go up.
	elseif notsosuper_VAR_DIRECTION == "right" then
		direction = Vector( math.random( 20 )-10, math.random( 20 )-10, math.random( 20 )-5 ) -- Make it random, slightly biased to go up.
	elseif notsosuper_VAR_DIRECTION == "down" then
		direction = Vector( math.random( 20 )-10, math.random( 20 )-10, math.random( 20 )-5 ) -- Make it random, slightly biased to go up.
	else
		notsosuper_MSG_PLY(ply,"You have used an incorrect direction, please use: notsosuper_slap <name> <up|down|left|right> <power>") return
	end
	
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
	
	if not notsosuper_VAR_PLAYER:Alive() then NOTSOSUPER_MSG_PLY(ply,"The target is not alive.") return end
	
	if notsosuper_VAR_PLAYER.PlayerFrozen then NOTSOSUPER_MSG_PLY(ply,"The target is frozen.") return end
	
	if notsosuper_VAR_PLAYER:InVehicle() then NOTSOSUPER_MSG_PLY(ply,"The target is in a vehicle.") return end
	
	if notsosuper_VAR_PLAYER:GetMoveType() == MOVETYPE_NOCLIP then NOTSOSUPER_MSG_PLY(ply,"The target is in noclip.") return end
	
	if notsosuper_VAR_PLAYER:GetMoveType() == MOVETYPE_OBSERVER then NOTSOSUPER_MSG_PLY(ply,"The target is in spectator.") return end
	
	local dTime = 1
	
	if notsosuper_VAR_POWER ~= nil then
		direction:Normalize()
	else
		notsosuper_VAR_POWER = 1
	end
	
	-- Times it by the time elapsed since the last update.
	local accel = notsosuper_VAR_POWER * dTime
	-- Convert our scalar accel to a vector accel
	accel = direction * accel
	
	if notsosuper_VAR_PLAYER:GetMoveType() == MOVETYPE_VPHYSICS then
		-- a = f/m , so times by mass to get the force.
		local force = accel * notsosuper_VAR_PLAYER:GetPhysicsObject():GetMass()
		notsosuper_VAR_PLAYER:GetPhysicsObject():ApplyForceCenter( force )
	else
		notsosuper_VAR_PLAYER:SetVelocity( accel ) -- As it turns out, SetVelocity() is actually SetAccel() in GM10
	end
	
	local notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was slapped "..NIGGER_VAR_DIRECTION.." with force of "..NIGGER_VAR_POWER
	notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
	
	local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] slapped "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."]"..NIGGER_VAR_DIRECTION.." with force of "..NIGGER_VAR_POWER
	notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
end
concommand.Add("notsosuper_slap", notsosuper_CMD_SLAP)
lechat.AddCmd("/slap ", nil, notsosuper_CMD_SLAP)
