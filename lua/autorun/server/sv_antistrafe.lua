local function notsosuper_STRAFEHACK(ply, movedata)
	-- Do not check spectators or bots
	if ply:Team() == TEAM_SPECTATOR then return end
	if ply:IsBot() then return end
	-- Strafe Hacks Detection
	local notsosuper_VAR_MOVESPEED = movedata:GetSideSpeed()
	local notsosuper_VAR_THETIME = CurTime()
	local notsosuper_LOG_MESSAGE
	if(!ply:KeyDown(IN_MOVELEFT) || !ply:KeyDown(IN_MOVERIGHT)) then
		---------------------
		-- NoStrafe, WOnly, Sideways
		---------------------
		if notsosuper_VAR_MOVESPEED < 0 then
			---------------------
			-- LEFT NON-KEY
			---------------------
			if notsosuper_VAR_MOVESPEED <= -1000 || NOTSOSUPER_VAR_MOVESPEED >= -100 then return end
			if ply.notsosuper_VAR_LEFT_SPEED == nil then ply.NOTSOSUPER_VAR_LEFT_SPEED = 0 return end
			if ply.notsosuper_VAR_LEFT_DETECTIONS == nil then ply.NOTSOSUPER_VAR_LEFT_DETECTIONS = 0 return end
			if ply.notsosuper_VAR_LASTTIME == nil then  ply.NOTSOSUPER_VAR_LASTTIME = CurTime() return end
			if ply.notsosuper_VAR_LEFT_DETECTIONS >= 25 && not ply.PlayerBanned then
				game.ConsoleCommand("notsosuper_ban \""..ply:SteamID().."\" 0 [notsosuper] Non-Key Strafe Hack\n")
				ply.PlayerBanned = true
				return
			end
			if(notsosuper_VAR_THETIME >= ply.NOTSOSUPER_VAR_LASTTIME + 15 || (ply.NIGGER_VAR_LEFT_SPEED + NIGGER_VAR_MOVESPEED) > -50 || (ply.NIGGER_VAR_LEFT_SPEED - NIGGER_VAR_MOVESPEED) < 0) then
				ply.notsosuper_VAR_LASTTIME = CurTime()
				ply.notsosuper_VAR_LEFT_DETECTIONS = 0
				ply.notsosuper_VAR_LEFT_SPEED = NOTSOSUPER_VAR_MOVESPEED
				return
			end
			ply.notsosuper_VAR_LEFT_DETECTIONS = ply.NOTSOSUPER_VAR_LEFT_DETECTIONS + 1
			ply.notsosuper_VAR_LASTTIME = CurTime()
			notsosuper_LOG_MESSAGE = ply:Nick().." ["..ply:SteamID().."] detected strafe hack [direction] non-key left [speed] "..NOTSOSUPER_VAR_MOVESPEED.." [detections] "..ply.NIGGER_VAR_LEFT_DETECTIONS
			notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
			ply.notsosuper_VAR_LEFT_SPEED = NOTSOSUPER_VAR_MOVESPEED
		elseif notsosuper_VAR_MOVESPEED > 0 then
			---------------------
			-- RIGHT NON-KEY
			---------------------
			if notsosuper_VAR_MOVESPEED >= 1000 || NOTSOSUPER_VAR_MOVESPEED <= 100 then return end
			if ply.notsosuper_VAR_RIGHT_SPEED == nil then ply.NOTSOSUPER_VAR_RIGHT_SPEED = 0 return end
			if ply.notsosuper_VAR_RIGHT_DETECTIONS == nil then ply.NOTSOSUPER_VAR_RIGHT_DETECTIONS = 0 return end
			if ply.notsosuper_VAR_LASTTIME == nil then  ply.NOTSOSUPER_VAR_LASTTIME = CurTime() return end
			if ply.notsosuper_VAR_RIGHT_DETECTIONS >= 25 && not ply.PlayerBanned then
				game.ConsoleCommand("notsosuper_ban \""..ply:SteamID().."\" 0 [notsosuper] Non-Key Strafe Hack\n")
				ply.PlayerBanned = true
				return
			end
			if(notsosuper_VAR_THETIME >= ply.NOTSOSUPER_VAR_LASTTIME + 15 || (ply.NIGGER_VAR_RIGHT_SPEED - NIGGER_VAR_MOVESPEED) < 50 || (ply.NIGGER_VAR_RIGHT_SPEED - NIGGER_VAR_MOVESPEED) > 0) then
				ply.notsosuper_VAR_LASTTIME = CurTime()
				ply.notsosuper_VAR_RIGHT_DETECTIONS = 0
				ply.notsosuper_VAR_RIGHT_SPEED = NOTSOSUPER_VAR_MOVESPEED
				return
			end
			ply.notsosuper_VAR_RIGHT_DETECTIONS = ply.NOTSOSUPER_VAR_RIGHT_DETECTIONS + 1
			ply.notsosuper_VAR_LASTTIME = CurTime()
			notsosuper_LOG_MESSAGE = ply:Nick().." ["..ply:SteamID().."] detected strafe hack [direction] non-key right [speed] "..NOTSOSUPER_VAR_MOVESPEED.." [detections] "..ply.NIGGER_VAR_RIGHT_DETECTIONS
			notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
			ply.notsosuper_VAR_RIGHT_SPEED = NOTSOSUPER_VAR_MOVESPEED
		end
	elseif(ply:KeyDown(IN_MOVELEFT) || ply:KeyDown(IN_MOVERIGHT)) then
		-- Normal Strafe, Telehop
		if notsosuper_VAR_MOVESPEED < 0 then
			---------------------
			-- LEFT NON-KEY
			---------------------
			if notsosuper_VAR_MOVESPEED <= -1000 || NOTSOSUPER_VAR_MOVESPEED >= -100 then return end
			if ply.notsosuper_VAR_K_LEFT_SPEED == nil then ply.NOTSOSUPER_VAR_K_LEFT_SPEED = 0 return end
			if ply.notsosuper_VAR_K_LEFT_DETECTIONS == nil then ply.NOTSOSUPER_VAR_K_LEFT_DETECTIONS = 0 return end
			if ply.notsosuper_VAR_LASTTIME == nil then  ply.NOTSOSUPER_VAR_LASTTIME = CurTime() return end
			if ply.notsosuper_VAR_K_LEFT_DETECTIONS >= 25 && not ply.PlayerBanned then
				game.ConsoleCommand("notsosuper_ban \""..ply:SteamID().."\" 0 [notsosuper] Key Strafe Hack\n")
				ply.PlayerBanned = true
				return
			end
			if(notsosuper_VAR_THETIME >= ply.NOTSOSUPER_VAR_LASTTIME + 15 || (ply.NIGGER_VAR_K_LEFT_SPEED + NIGGER_VAR_MOVESPEED) > -50 || (ply.NIGGER_VAR_K_LEFT_SPEED - NIGGER_VAR_MOVESPEED) < 0) then
				ply.notsosuper_VAR_LASTTIME = CurTime()
				ply.notsosuper_VAR_K_LEFT_DETECTIONS = 0
				ply.notsosuper_VAR_K_LEFT_SPEED = NOTSOSUPER_VAR_MOVESPEED
				return
			end
			ply.notsosuper_VAR_K_LEFT_DETECTIONS = ply.NOTSOSUPER_VAR_K_LEFT_DETECTIONS + 1
			ply.notsosuper_VAR_LASTTIME = CurTime()
			notsosuper_LOG_MESSAGE = ply:Nick().." ["..ply:SteamID().."] detected strafe hack [direction] key left [speed] "..NOTSOSUPER_VAR_MOVESPEED.." [detections] "..ply.NIGGER_VAR_K_LEFT_DETECTIONS
			notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
			ply.notsosuper_VAR_K_LEFT_SPEED = NOTSOSUPER_VAR_MOVESPEED
		elseif notsosuper_VAR_MOVESPEED > 0 then
			---------------------
			-- RIGHT NON-KEY
			---------------------
			if notsosuper_VAR_MOVESPEED >= 1000 || NOTSOSUPER_VAR_MOVESPEED <= 100 then return end
			if ply.notsosuper_VAR_K_RIGHT_SPEED == nil then ply.NOTSOSUPER_VAR_K_RIGHT_SPEED = 0 return end
			if ply.notsosuper_VAR_K_RIGHT_DETECTIONS == nil then ply.NOTSOSUPER_VAR_K_RIGHT_DETECTIONS = 0 return end
			if ply.notsosuper_VAR_LASTTIME == nil then  ply.NOTSOSUPER_VAR_LASTTIME = CurTime() return end
			if ply.notsosuper_VAR_K_RIGHT_DETECTIONS >= 25 && not ply.PlayerBanned then
				game.ConsoleCommand("notsosuper_ban \""..ply:SteamID().."\" 0 [notsosuper] Key Strafe Hack\n")
				ply.PlayerBanned = true
				return
			end
			if(notsosuper_VAR_THETIME >= ply.NOTSOSUPER_VAR_LASTTIME + 15 || (ply.NIGGER_VAR_K_RIGHT_SPEED - NIGGER_VAR_MOVESPEED) < 50 || (ply.NIGGER_VAR_K_RIGHT_SPEED - NIGGER_VAR_MOVESPEED) > 0) then
				ply.notsosuper_VAR_LASTTIME = CurTime()
				ply.notsosuper_VAR_K_RIGHT_DETECTIONS = 0
				ply.notsosuper_VAR_K_RIGHT_SPEED = NOTSOSUPER_VAR_MOVESPEED
				return
			end
			ply.notsosuper_VAR_K_RIGHT_DETECTIONS = ply.NOTSOSUPER_VAR_K_RIGHT_DETECTIONS + 1
			ply.notsosuper_VAR_LASTTIME = CurTime()
			notsosuper_LOG_MESSAGE = ply:Nick().." ["..ply:SteamID().."] detected strafe hack [direction] key right [speed] "..NOTSOSUPER_VAR_MOVESPEED.." [detections] "..ply.NIGGER_VAR_K_RIGHT_DETECTIONS
			notsosuper_GLB_LOG.AddLogLine(NOTSOSUPER_LOG_MESSAGE)
			ply.notsosuper_VAR_K_RIGHT_SPEED = NOTSOSUPER_VAR_MOVESPEED
		end
	end
end
hook.Add("Move", "notsosuper_STRAFEHACK", NOTSOSUPER_STRAFEHACK)

local function notsosuper_MOVEHACK(ply, movedata)
	-- Do not check spectators
	if ply:Team() == TEAM_SPECTATOR then return end
	-- Block +left and +right
	if ply:KeyDown(IN_LEFT) then movedata:SetVelocity(Vector(0, 0, 0)) return end
	if ply:KeyDown(IN_RIGHT) then movedata:SetVelocity(Vector(0, 0, 0)) return end
end
hook.Add("SetupMove", "notsosuper_MOVEHACK", NOTSOSUPER_MOVEHACK)
