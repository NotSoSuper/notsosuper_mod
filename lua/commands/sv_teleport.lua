if (!SERVER) then return end

-- Utility for all teleport commands
local function playerSend( from, to, force )
	if not to:IsInWorld() and not force then return false end -- No way we can do this one

	local yawForward = to:EyeAngles().yaw
	local directions = { -- Directions to try
		math.NormalizeAngle( yawForward - 180 ), -- Behind first
		math.NormalizeAngle( yawForward + 90 ), -- Right
		math.NormalizeAngle( yawForward - 90 ), -- Left
		yawForward,
	}

	local t = {}
	t.start = to:GetPos() + Vector( 0, 0, 32 ) -- Move them up a bit so they can travel across the ground
	t.filter = { to, from }

	local i = 1
	t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47 -- (33 is player width, this is sqrt( 33^2 * 2 ))
	local tr = util.TraceEntity( t, from )
	while tr.Hit do -- While it's hitting something, check other angles
		i = i + 1
		if i > #directions then	 -- No place found
			if force then
				return to:GetPos() + Angle( 0, directions[ 1 ], 0 ):Forward() * 47
			else
				return false
			end
		end

		t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47

		tr = util.TraceEntity( t, from )
	end

	return tr.HitPos
end

local function notsosuper_CMD_BRING(ply,cmd,args)
	if (!ply and type(ply) == "string" and !ply:IsPlayer()) then notsosuper_MSG_PLY(ply,"You cannot use this via console.") return end
	if (ply:IsValid() && !ply:IsLeader()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
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
	
	if not notsosuper_VAR_PLAYER:Alive() then NOTSOSUPER_MSG_PLY(ply,"The target is not alive.") return end
	
	if not ply:Alive() then notsosuper_MSG_PLY(ply,"You are dead.") return end

	if ply:InVehicle() then notsosuper_MSG_PLY(ply,"Please leave the vehicle first.") return end
	
	local newpos = playerSend( notsosuper_VAR_PLAYER, ply, NOTSOSUPER_VAR_PLAYER:GetMoveType() == MOVETYPE_NOCLIP )
	if not newpos then notsosuper_MSG_PLY(ply,"Can't find a place to put the target.") return end
	
	if notsosuper_VAR_PLAYER:InVehicle() then
		notsosuper_VAR_PLAYER:ExitVehicle()
	end
	
	local newang = (ply:GetPos() - newpos):Angle()
	
	local notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was brought to "..NIGGER_VAR_ADMINNAME
	notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
	
	notsosuper_VAR_PLAYER:SetPos( newpos )
	notsosuper_VAR_PLAYER:SetEyeAngles( newang )
	notsosuper_VAR_PLAYER:SetLocalVelocity( Vector( 0, 0, 0 ) ) -- Stop!
	
	local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] brought "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."]"
	notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
end
concommand.Add("notsosuper_bring", notsosuper_CMD_BRING)
lechat.AddCmd("/bring ", nil, notsosuper_CMD_BRING)

local function notsosuper_CMD_GOTO(ply,cmd,args)
	if (!ply and type(ply) == "string" and !ply:IsPlayer()) then notsosuper_MSG_PLY(ply,"You cannot use this via console.") return end
	if (ply:IsValid() && !ply:IsLeader()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
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
	
	if not notsosuper_VAR_PLAYER:Alive() then NOTSOSUPER_MSG_PLY(ply,"The target is not alive.") return end

	if not ply:Alive() then notsosuper_MSG_PLY(ply,"You are dead.") return end

	if notsosuper_VAR_PLAYER:InVehicle() and ply:GetMoveType() ~= MOVETYPE_NOCLIP then NOTSOSUPER_MSG_PLY(ply,"Target is in a vehicle! Noclip and use this command to force a goto.") return end

	local newpos = playerSend( ply, notsosuper_VAR_PLAYER, ply:GetMoveType() == MOVETYPE_NOCLIP )
	if not newpos then notsosuper_MSG_PLY(ply,"Can't find a place to put you! Noclip and use this command to force a goto.") return end

	if ply:InVehicle() then
		ply:ExitVehicle()
	end

	local newang = (notsosuper_VAR_PLAYER:GetPos() - newpos):Angle()
	
	local notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." went to "..NIGGER_VAR_NAME
	notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
	
	ply:SetPos( newpos )
	ply:SetEyeAngles( newang )
	ply:SetLocalVelocity( Vector( 0, 0, 0 ) ) -- Stop!
	
	local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] went to "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."]"
	notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
end
concommand.Add("notsosuper_goto", notsosuper_CMD_GOTO)
lechat.AddCmd("/goto ", nil, notsosuper_CMD_GOTO)

local function notsosuper_CMD_SEND(ply,cmd,args)
	if (ply:IsValid() && !ply:IsLeader()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
	if not args[1] then notsosuper_MSG_PLY(ply,"You have not entered a player name to send.") return end
	if not args[2] then notsosuper_MSG_PLY(ply,"You have not entered a player name as a destination.") return end
	
	local notsosuper_VAR_PLAYER1 = NOTSOSUPER_GLB_GETUSER(args[1])
	if notsosuper_VAR_PLAYER1 == false then NOTSOSUPER_MSG_PLY(ply,"The first targeted player could not be found, or there were too many targets.") return end
	
	local notsosuper_VAR_NAME1 = NOTSOSUPER_VAR_PLAYER1:Nick()
	local notsosuper_VAR_STEAMID1 = NOTSOSUPER_VAR_PLAYER1:SteamID()
	
	local notsosuper_VAR_PLAYER2 = NOTSOSUPER_GLB_GETUSER(args[2])
	if notsosuper_VAR_PLAYER2 == false then NOTSOSUPER_MSG_PLY(ply,"The second targeted player could not be found, or there were too many targets.") return end
	
	local notsosuper_VAR_NAME2 = NOTSOSUPER_VAR_PLAYER2:Nick()
	local notsosuper_VAR_STEAMID2 = NOTSOSUPER_VAR_PLAYER2:SteamID()
	
	if notsosuper_VAR_NAME1 == NOTSOSUPER_VAR_NAME2 then NIGGER_MSG_PLY(ply,"You listed the notsosupere target twice! Please use two different targets.") return end
	
	local notsosuper_VAR_ADMINID = "(Console)"
	local notsosuper_VAR_ADMINNAME = "(Console)"
	local notsosuper_VAR_ADMINIP = "(Console)"
	if ply and type(ply) != "string" and ply:IsPlayer() then
		notsosuper_VAR_ADMINID = ply:SteamID()
		notsosuper_VAR_ADMINNAME = ply:Nick()
		notsosuper_VAR_ADMINIP = ply:IPAddress()
	end

	local nick = notsosuper_VAR_PLAYER1:Nick() -- Going to use this for our error (if we have one)

	if not notsosuper_VAR_PLAYER1:Alive() or not NOTSOSUPER_VAR_PLAYER2:Alive() then
		if not notsosuper_VAR_PLAYER2:Alive() then
			nick = notsosuper_VAR_PLAYER2:Nick()
		end
		notsosuper_MSG_PLY(ply,"The target is not alive: "..nick..".")
		return
	end

	if notsosuper_VAR_PLAYER2:InVehicle() and NOTSOSUPER_VAR_PLAYER1:GetMoveType() ~= MOVETYPE_NOCLIP then NIGGER_MSG_PLY(ply,"The target is in a vehicle.") return end

	local newpos = playerSend( notsosuper_VAR_PLAYER1, NOTSOSUPER_VAR_PLAYER2, NIGGER_VAR_PLAYER1:GetMoveType() == MOVETYPE_NOCLIP )
	if not newpos then notsosuper_MSG_PLY(ply,"Cannot find a place to put the target.") return end

	if notsosuper_VAR_PLAYER1:InVehicle() then
		notsosuper_VAR_PLAYER1:ExitVehicle()
	end

	local newang = (notsosuper_VAR_PLAYER1:GetPos() - newpos):Angle()
	
	local notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME1.." was sent to "..NIGGER_VAR_NAME2
	notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
	
	notsosuper_VAR_PLAYER1:SetPos( newpos )
	notsosuper_VAR_PLAYER1:SetEyeAngles( newang )
	notsosuper_VAR_PLAYER1:SetLocalVelocity( Vector( 0, 0, 0 ) ) -- Stop!
	
	local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] sent "..NIGGER_VAR_NAME1.." ["..NIGGER_VAR_STEAMID2.."] to "..NIGGER_VAR_NAME2.." ["..NIGGER_VAR_STEAMID2.."]"
	notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
end
concommand.Add("notsosuper_send", notsosuper_CMD_SEND)
lechat.AddCmd("/send ", nil, notsosuper_CMD_SEND)

local function notsosuper_CMD_TELEPORT(ply,cmd,args)
	if (!ply and type(ply) == "string" and !ply:IsPlayer()) then notsosuper_MSG_PLY(ply,"You cannot use this via console.") return end
	if (ply:IsValid() && !ply:IsLeader()) then notsosuper_MSG_PLY(ply,"Access denied! You don't have permission to use that command.") return end
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

	if not notsosuper_VAR_PLAYER:Alive() then NOTSOSUPER_MSG_PLY(ply,"The target is not alive.") return end

	local t = {}
	t.start = ply:GetPos() + Vector( 0, 0, 32 ) -- Move them up a bit so they can travel across the ground
	t.endpos = ply:GetPos() + ply:EyeAngles():Forward() * 16384
	t.filter = notsosuper_VAR_PLAYER
	if notsosuper_VAR_PLAYER ~= ply then
		t.filter = { notsosuper_VAR_PLAYER, ply }
	end
	local tr = util.TraceEntity( t, notsosuper_VAR_PLAYER )

	local pos = tr.HitPos

	if notsosuper_VAR_PLAYER == ply and pos:Distance( NOTSOSUPER_VAR_PLAYER:GetPos() ) < 64 then -- Laughable distance
		return
	end

	if notsosuper_VAR_PLAYER:InVehicle() then
		notsosuper_VAR_PLAYER:ExitVehicle()
	end

	notsosuper_VAR_PLAYER:SetPos( pos )
	notsosuper_VAR_PLAYER:SetLocalVelocity( Vector( 0, 0, 0 ) ) -- Stop!

	if notsosuper_VAR_PLAYER ~= ply then
		local notsosuper_VAR_MESSAGE = NOTSOSUPER_VAR_NAME.." was teleported"
		notsosuper_MSG_ALL(NOTSOSUPER_VAR_ADMINNAME,NIGGER_VAR_MESSAGE)
	
		local notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_ADMINNAME.." ["..NIGGER_VAR_ADMINID.."] teleported "..NIGGER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."]"
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	end
end
concommand.Add("notsosuper_teleport", notsosuper_CMD_TELEPORT)
lechat.AddCmd("/teleport ", nil, notsosuper_CMD_TELEPORT)
