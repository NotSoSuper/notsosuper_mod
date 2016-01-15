if (!SERVER) then return end

local function notsosuper_TIME_THREE(ply,oldplayerpos,chpropposition,proptoplayerdistance)
	local notsosuper_VAR_NAME = ply:Nick()
	local notsosuper_VAR_STEAMID = ply:SteamID()
	local notsosuper_VAR_MESSAGE
	local notsosuper_LOG_MESSAGE
	
	local newplayerposition = ply:GetPos()
	if(newplayerposition == chpropposition) then
		notsosuper_MSG_PLY(ply,"Stage 3/3 - You have been succesfully unstuck, otherwise try again.")
		
		notsosuper_VAR_MESSAGE = " used unstuck (distance: "..proptoplayerdistance..")"
		notsosuper_MSG_ADMINS(NOTSOSUPER_VAR_NAME,NIGGER_VAR_MESSAGE)
		
		notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."] used unstuck (distance: "..proptoplayerdistance..")"
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	else
		ply:SetPos(oldplayerpos)
		
		notsosuper_MSG_PLY(ply,"FAILED - Try again without using movement keys.")
		
		notsosuper_VAR_MESSAGE = " used unstuck but it failed (3) - keep an eye for possible misuse."
		notsosuper_MSG_ADMINS(NOTSOSUPER_VAR_NAME,NIGGER_VAR_MESSAGE)
		
		notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."] used unstuck (distance: "..proptoplayerdistance..") but it failed (3)."
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
	end
	return
end

local function notsosuper_TIME_TWO(ply,oldplayerpos)
	local notsosuper_VAR_NAME = ply:Nick()
	local notsosuper_VAR_STEAMID = ply:SteamID()
	local notsosuper_VAR_MESSAGE
	local notsosuper_LOG_MESSAGE
	
	ply:Lock()
	local oldplayerposfinal = ply:GetPos()
	if oldplayerpos != oldplayerposfinal then
		ply:UnLock()
		
		ply:SetPos(oldplayerpos)
		
		notsosuper_MSG_PLY(ply,"FAILED - Try again without using movement keys.")
		
		notsosuper_VAR_MESSAGE = " used unstuck but it failed (1) - keep an eye for possible misuse."
		notsosuper_MSG_ADMINS(NOTSOSUPER_VAR_NAME,NIGGER_VAR_MESSAGE)
		
		notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."] used unstuck but it failed (1)."
		notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
		return
	end
	
	local pos = ply:GetShootPos()
	local ang = ply:GetAimVector()
	local forward = ply:GetForward()
	local center = Vector( 0, 0, 30 )
	local realpos = ( (pos + center ) + (forward * 75) )
	local chprop = ents.Create( "prop_physics" )
	
	chprop:SetModel("models/props_c17/oildrum001.mdl")
	chprop:SetPos(realpos)
	chprop:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	chprop:SetOwner(ply)
	chprop:SetNoDraw(true)
	chprop:DrawShadow(false)
	chprop:DropToFloor()
	chprop:Spawn()
	local p = chprop:GetPhysicsObject()
	if IsValid(p) then
		p:EnableMotion(false)
	end
	
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = chprop:GetPos()
	tracedata.filter = ply	
	local trace = util.TraceLine(tracedata)
	
	timer.Create( "CheckUseAblePos", 3, 1, function()
	ply:UnLock()
		if IsValid( chprop:GetGroundEntity() ) then
			local gent = chprop:GetGroundEntity()
			gent:SetCollisionGroup( COLLISION_GROUP_WEAPON )
				timer.Simple( 3, function()
					gent:SetCollisionGroup( COLLISION_GROUP_NONE )
				end)
		end
		if chprop:IsInWorld() then
			local chpropposition = chprop:GetPos()
			local proptoplayerdistance = tonumber(oldplayerposfinal:Distance(chpropposition))
			if proptoplayerdistance <= 300 then
				if trace.Entity == chprop then
					if oldplayerpos == oldplayerposfinal then
						ply:SetPos(chpropposition)
						
						timer.Simple(3, function()
							notsosuper_TIME_THREE(ply,oldplayerpos,chpropposition,proptoplayerdistance)
						end)
					else
						ply:SetPos(oldplayerpos)
						
						notsosuper_MSG_PLY(ply,"FAILED - Try again without using movement keys.")
						
						notsosuper_VAR_MESSAGE = " used unstuck but it failed (2) - keep an eye for possible misuse."
						notsosuper_MSG_ADMINS(NOTSOSUPER_VAR_NAME,NIGGER_VAR_MESSAGE)
						
						notsosuper_LOG_MESSAGE = NOTSOSUPER_VAR_NAME.." ["..NIGGER_VAR_STEAMID.."] used unstuck (distance: "..proptoplayerdistance..") but it failed (2)."
						notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
					end
				else
					notsosuper_MSG_PLY(ply,"Please aim away from entities and try again.")
				end
			else
				notsosuper_MSG_PLY(ply,"Please look elsewhere and try again, the distance is too far.")
			end
		else
			notsosuper_MSG_PLY(ply,"Please aim away from walls and try again.")
		end
		chprop:Remove()
	end)
end

local function notsosuper_TIME_ONE(ply,oldplayerpos)
	ply:UnLock()
	notsosuper_MSG_PLY(ply,"Stage 2/3 - Look away from the wall(s) and do not use movement keys.")
	timer.Simple(2, function()
		notsosuper_TIME_TWO(ply,oldplayerpos)
	end)
end

local function notsosuper_CMD_UNSTUCK(ply,cmd,args)
	if (!ply and type(ply) == "string" and !ply:IsPlayer()) then notsosuper_MSG_PLY(ply,"You cannot use this via console.") return end
	if ply.notsosuper_VAR_COOLDOWN == nil then ply.NOTSOSUPER_VAR_COOLDOWN = CurTime() - 1 end
	if ply.notsosuper_VAR_COOLDOWN > CurTime() then NOTSOSUPER_MSG_PLY(ply,"You must wait before you can use this again.") return end
	ply.notsosuper_VAR_COOLDOWN = CurTime() + 15
	
	if game.GetMap() == "bhop_choice" then notsosuper_MSG_PLY(ply,"You cannot use this command on this map.")	ply:UnLock()	return end
	if game.GetMap() == "bhop_mist" then notsosuper_MSG_PLY(ply,"You cannot use this command on this map.")	ply:UnLock()	return end
	
	if ply.InSpawn then notsosuper_MSG_PLY(ply,"You cannot use this command whilst in spawn.") return end
	if ply.timerFinish != nil then notsosuper_MSG_PLY(ply,"You cannot use this command until you start the timer, use /r instead.") return end
	if ply.timer == nil then notsosuper_MSG_PLY(ply,"You cannot use this command until you start the timer, use /r instead.") return end
	
	if ply:GetMoveType() == MOVETYPE_OBSERVER then notsosuper_MSG_PLY(ply,"You cannot use this whilst spectating.") return end
	if ply:Team() == TEAM_SPECTATOR then notsosuper_MSG_PLY(ply,"You cannot use this whilst spectating.") return end
	if not ply:Alive() then notsosuper_MSG_PLY(ply,"You cannot use this whilst dead.") return end
	
	ply:Lock()
	local oldplayerpos = ply:GetPos()
	
	notsosuper_MSG_PLY(ply,"Stage 1/3 - Look away from the wall(s) and do not use movement keys.")
	
	timer.Simple(2, function()
		notsosuper_TIME_ONE(ply,oldplayerpos)
	end)
end
concommand.Add("notsosuper_unstuck", notsosuper_CMD_UNSTUCK)
lechat.AddCmd("/stuck", nil, notsosuper_CMD_UNSTUCK)
lechat.AddCmd("/unstuck", nil, notsosuper_CMD_UNSTUCK)
lechat.AddCmd("!unstuck", nil, notsosuper_CMD_UNSTUCK)
lechat.AddCmd("!stuck", nil, notsosuper_CMD_UNSTUCK)
