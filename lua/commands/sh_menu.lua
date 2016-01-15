local function notsosuper_CMD_ADMINMENU(ply,cmd,args)
	if not ply:IsAdmin() then return end
	
	rightadminmenu = vgui.Create("DMenu")
	rightadminmenu:SetMinimumWidth(200)
	rightadminmenu.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, rightadminmenu:GetMinimumWidth(), rightadminmenu:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	local title = rightadminmenu:AddOption("NotSoSuper Gaming (9/11)", function() end)
	title:SetPaintBackground(false)
	--Should add a spacer to keep the submenus from auto opening.
	rightadminmenu:AddSpacer()
	rightadminmenu:AddSpacer()
	rightadminmenu:AddSpacer()
	
	local jailcmds, pnl
	local jbguardban, pnl
	local firewarden, pnl
	local jbswapteam, pnl
	local jbspectator, pnl
	local terrortowncmds, pnl
	local ttalldmglog
	local ttplydmglog, pnl
	local tttraitorlist
	local ttdamagemenu
	
	if gamemode.Get("jailbreak") then
		-- "Jailbreak" Commands submenu.
		jailcmds, pnl = rightadminmenu:AddSubMenu("Jailbreak")
		jailcmds:SetMinimumWidth(200)
		jailcmds.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, jailcmds:GetMinimumWidth(), jailcmds:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/joystick.png")
		
		rightadminmenu:AddSpacer()
		
		---------------------------
		--- Jail Break Commands ---
		---------------------------
		-- Guard Ban
		jbguardban, pnl = jailcmds:AddSubMenu("Guard Ban")
		jbguardban:SetMinimumWidth(200)
		jbguardban.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, jbguardban:GetMinimumWidth(), jbguardban:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/delete.png")
		
		-- Fire warden menu
		firewarden, pnl = jailcmds:AddSubMenu("Fire warden")
		firewarden:SetMinimumWidth(200)
		firewarden.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, firewarden:GetMinimumWidth(), firewarden:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/fire.png")
		
		-- Swap Team menu
		jbswapteam, pnl = jailcmds:AddSubMenu("Swap team")
		jbswapteam:SetMinimumWidth(200)
		jbswapteam.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, jbswapteam:GetMinimumWidth(), jbswapteam:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/arrow_refresh.png")
		
		-- Move to Spectator menu
		jbspectator, pnl = jailcmds:AddSubMenu("Move to Spectator")
		jbspectator:SetMinimumWidth(200)
		jbspectator.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, jbspectator:GetMinimumWidth(), jbspectator:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/bug.png")
	elseif gamemode.Get("terrortown") then
		-- "TTT" Commands submenu.
		terrortowncmds, pnl = rightadminmenu:AddSubMenu("Trouble in Terrorist Town")
		terrortowncmds:SetMinimumWidth(200)
		terrortowncmds.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, terrortowncmds:GetMinimumWidth(), terrortowncmds:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/joystick.png")
		
		rightadminmenu:AddSpacer()
		
		---------------------------
		---     TTT Commands    ---
		---------------------------
		-- Damage Log
		ttalldmglog = terrortowncmds:AddOption( "Print Damage Log for All", function()
			RunConsoleCommand("ttt_print_adminreport")
			rightadminmenu:Hide()
		end):SetIcon("icon16/page_white_magnify.png")
		-- Player Damage Logs
		ttplydmglog, pnl = terrortowncmds:AddSubMenu("Print Damage Log for...")
		ttplydmglog:SetMinimumWidth(200)
		ttplydmglog.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, ttplydmglog:GetMinimumWidth(), ttplydmglog:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/page_white_magnify.png")
		-- Traitor List
		tttraitorlist = terrortowncmds:AddOption( "Print Traitor List", function()
			RunConsoleCommand("ttt_print_traitors")
			rightadminmenu:Hide()
		end):SetIcon("icon16/user_red.png")
		-- Damage Log Menu
		ttdamagemenu = terrortowncmds:AddOption( "Open RDM Manager", function()
			RunConsoleCommand("damagelog")
			rightadminmenu:Hide()
		end):SetIcon("icon16/user_green.png")
	end
	
	---------------------------
	---  General Commands  ---
	---------------------------
	
	-- Gag menu
	local gag, pnl = rightadminmenu:AddSubMenu("Mute")
	gag:SetMinimumWidth(200)
	gag.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, gag:GetMinimumWidth(), gag:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/sound_mute.png")
	
	rightadminmenu:AddSpacer()
	
	-- Ungag menu
	local ungag, pnl = rightadminmenu:AddSubMenu("Unmute")
	ungag:SetMinimumWidth(200)
	ungag.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, ungag:GetMinimumWidth(), ungag:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/sound_low.png")
	
	rightadminmenu:AddSpacer()
	
	-- Mute menu
	local mute, pnl = rightadminmenu:AddSubMenu("Gag")
	mute:SetMinimumWidth(200)
	mute.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, mute:GetMinimumWidth(), mute:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/text_strikethrough.png")
	
	rightadminmenu:AddSpacer()
	
	-- Unmute menu
	local unmute, pnl = rightadminmenu:AddSubMenu("Ungag")
	unmute:SetMinimumWidth(200)
	unmute.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, unmute:GetMinimumWidth(), unmute:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/text_signature.png")
	
	rightadminmenu:AddSpacer()
	
	-- Kick menu
	local kick, pnl = rightadminmenu:AddSubMenu("Kick")
	kick:SetMinimumWidth(200)
	kick.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, kick:GetMinimumWidth(), kick:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/door_open.png")
	
	rightadminmenu:AddSpacer()
	
	-- Ban menu
	local ban, pnl = rightadminmenu:AddSubMenu("Ban")
	ban:SetMinimumWidth(200)
	ban.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, ban:GetMinimumWidth(), ban:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/exclamation.png")
	
	rightadminmenu:AddSpacer()
	
	-- Screenshot menu
	local sreecap, pnl = rightadminmenu:AddSubMenu("Capture User's Screen")
	sreecap:SetMinimumWidth(200)
	sreecap.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, sreecap:GetMinimumWidth(), sreecap:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/camera.png")
	
	rightadminmenu:AddSpacer()
	local funcmds, pnl
	local tpcmds, pnl
	local burn, pnl
	local extinguish, pnl
	local slapo, pnl
	local slay, pnl
	local respawn, pnl
	local freeze, pnl
	local unfreeze, pnl
	local god, pnl
	local ungod, pnl
	local noclip, pnl
	local unclip, pnl
	local teleport, pnl
	local bring, pnl
	local goto, pnl
	local sendto, pnl
	
	if ply:IsLeader() then
		-- "Fun" Commands submenu.
		funcmds, pnl = rightadminmenu:AddSubMenu("Fun")
		funcmds:SetMinimumWidth(200)
		funcmds.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, funcmds:GetMinimumWidth(), funcmds:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/rainbow.png")
		
		rightadminmenu:AddSpacer()
		
		-- "Teleportation" Commands submenu
		tpcmds, pnl = rightadminmenu:AddSubMenu("Teleportation")
		tpcmds:SetMinimumWidth(200)
		tpcmds.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, tpcmds:GetMinimumWidth(), tpcmds:GetMaxHeight(), Color(255,255,255,255), false, false, false, false)
		end
		pnl:SetIcon("icon16/asterisk_yellow.png")
		
		---------------------------
		---     Fun Commands    ---
		---------------------------
		
		-- Burn menu
		burn, pnl = funcmds:AddSubMenu("Burn")
		burn:SetMinimumWidth(200)
		burn.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, burn:GetMinimumWidth(), burn:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/fire.png")
		
		-- Extinguish menu
		extinguish, pnl = funcmds:AddSubMenu("Extinguish")
		extinguish:SetMinimumWidth(200)
		extinguish.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, extinguish:GetMinimumWidth(), extinguish:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/water.png")
		
		-- Slap menu
		slapo, pnl = funcmds:AddSubMenu("Slap")
		slapo:SetMinimumWidth(200)
		slapo.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, slapo:GetMinimumWidth(), slapo:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/sport_raquet.png")
		
		-- Slay menu
		slay, pnl = funcmds:AddSubMenu("Slay")
		slay:SetMinimumWidth(200)
		slay.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, slay:GetMinimumWidth(), slay:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/lightning.png")
		
		-- Respawn menu
		respawn, pnl = funcmds:AddSubMenu("Respawn")
		respawn:SetMinimumWidth(200)
		respawn.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, respawn:GetMinimumWidth(), respawn:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/user_add.png")
		
		-- Freeze menu
		freeze, pnl = funcmds:AddSubMenu("Freeze")
		freeze:SetMinimumWidth(200)
		freeze.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, freeze:GetMinimumWidth(), freeze:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/link.png")
		
		-- UnFreeze menu
		unfreeze, pnl = funcmds:AddSubMenu("Unfreeze")
		unfreeze:SetMinimumWidth(200)
		unfreeze.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, unfreeze:GetMinimumWidth(), unfreeze:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/link_break.png")
		
		-- God Enable menu
		god, pnl = funcmds:AddSubMenu("Enable Godmode")
		god:SetMinimumWidth(200)
		god.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, god:GetMinimumWidth(), god:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/pill_add.png")
		
		-- God Disable menu
		ungod, pnl = funcmds:AddSubMenu("Disable Godmode")
		ungod:SetMinimumWidth(200)
		ungod.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, ungod:GetMinimumWidth(), ungod:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/pill_delete.png")
		
		-- Noclip Enable menu
		noclip, pnl = funcmds:AddSubMenu("Enable Noclip")
		noclip:SetMinimumWidth(200)
		noclip.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, noclip:GetMinimumWidth(), noclip:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/transmit.png")
		
		-- Noclip Disable menu
		unclip, pnl = funcmds:AddSubMenu("Disable Noclip")
		unclip:SetMinimumWidth(200)
		unclip.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, unclip:GetMinimumWidth(), unclip:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/transmit_blue.png")
		
		---------------------------
		---  Teleport Commands  ---
		---------------------------
		
		-- Teleport menu
		teleport, pnl = tpcmds:AddSubMenu("Teleport Player")
		teleport:SetMinimumWidth(200)
		teleport.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, teleport:GetMinimumWidth(), teleport:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/arrow_up.png")
		
		-- Bring to me menu
		bring, pnl = tpcmds:AddSubMenu("Bring Player")
		bring:SetMinimumWidth(200)
		bring.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, bring:GetMinimumWidth(), bring:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/arrow_left.png")
		
		-- Goto menu
		goto, pnl = tpcmds:AddSubMenu("Go to Player")
		goto:SetMinimumWidth(200)
		goto.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, goto:GetMinimumWidth(), goto:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/arrow_right.png")
		
		-- Sendto menu
		sendto, pnl = tpcmds:AddSubMenu("Send Player to Player")
		sendto:SetMinimumWidth(200)
		sendto.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, sendto:GetMinimumWidth(), sendto:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/arrow_in.png")
	end
	
	rightadminmenu:AddSpacer()
	rightadminmenu:AddSpacer()
	rightadminmenu:AddSpacer()
	-- Close menu
	local closemenu = rightadminmenu:AddOption("Close Menu", function() end)
	closemenu:SetPaintBackground(false)
	
	rightadminmenu:AddSpacer()
	
	rightadminmenu:Open()
	rightadminmenu:SetPos(ScrW()/4, ScrH()/4)
	timer.Simple( 0, function() gui.SetMousePos( ScrW()/4+60, ScrH()/4+20 ) end)
		
for k, v in pairs (player.GetAll()) do
	local victim = v:SteamID()
	local victimname = v:Nick()
	
	--- General Command Players
	
	-- Gag
	local togag = gag:AddOption( v:Nick(), function()
		RunConsoleCommand("notsosuper_mute", tostring(victim))
		rightadminmenu:Hide()
	end)
	
	-- UnGag
	local toungag = ungag:AddOption( v:Nick(), function()
		RunConsoleCommand("notsosuper_unmute", tostring(victim))
		rightadminmenu:Hide()
	end)
	
	-- Mute
	local tomute = mute:AddOption( v:Nick(), function()
		RunConsoleCommand("notsosuper_gag", tostring(victim))
		rightadminmenu:Hide()
	end)
	
	-- UnMute
	local tounmute = unmute:AddOption( v:Nick(), function()
		RunConsoleCommand("notsosuper_ungag", tostring(victim))
		rightadminmenu:Hide()
	end)
	
	-- Kick	
	local tokick = kick:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"Kick Player", 
			"Why do you want to kick "..victimname.."?",
			"",
			function( text )
				RunConsoleCommand("notsosuper_kick", tostring(victim), tostring(text))
			end,
			function( text ) end)
	end)
		
	-- Ban
	local toban = ban:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"Ban Time", 
			"How long do you want to ban "..victimname.." (in minutes)?",
			"",
			function( text )
				Derma_StringRequest( 
					"Ban Reason", 
					"Why do you want to ban "..victimname.."?",
					"",
					function( text2 )
						RunConsoleCommand("notsosuper_ban", tostring(victim), tostring(text), tostring(text2))
					end,
				function( text2 ) end)
			end,
		function( text ) end)
	end)
	
	-- Screenshot
	local toscap = sreecap:AddOption( v:Nick(), function()
		RunConsoleCommand("notsosuper_screenshot", tostring(victim))
		rightadminmenu:Hide()
	end)
	
	if ply:IsLeader() then
		-- Burn
		local toburn = burn:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_burn", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		-- Extinguish
		local toextinguish = extinguish:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_extinguish", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		-- Slap
		local getslapped = slapo:AddOption( v:Nick(), function()
			Derma_StringRequest( 
				"Slap Direction", 
				"What direction do you want to slap "..victimname.."? (up|down|left|right)",
				"",
				function( text )
					Derma_StringRequest( 
						"Slap Distance", 
						"How far do you want to slap "..victimname.."?",
						"",
						function( text2 )
							RunConsoleCommand("notsosuper_slap", tostring(victim), tostring(text), tostring(text2))
						end,
						function( text2 ) end)
				end,
				function( text ) end)
		end)
		
		-- Slay
		local toslay = slay:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_slay", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		-- Respawn
		local torespawn = respawn:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_respawn", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		-- Freeze
		local tofreeze = freeze:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_freeze", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		-- Unfreeze
		local tounfreeze = unfreeze:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_unfreeze", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		-- God Enable
		local togod = god:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_god", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		-- God Disable
		local toungod = ungod:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_ungod", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		-- Noclip Enable
		local tonoclip = noclip:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_noclip", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		-- Noclip Disable
		local tounclip = unclip:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_unclip", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		-- Teleport
		local toteleport = teleport:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_teleport", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		-- Bring
		local tobring = bring:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_bring", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		-- Goto
		local togoto = goto:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_goto", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		-- Sendto
		local tosend = sendto:AddOption( v:Nick(), function()
			Derma_StringRequest( 
				"Send Player To", 
				"Who do you want to send "..victimname.." to?",
				"",
				function( text )
					RunConsoleCommand("notsosuper_send", tostring(victim), tostring(text))
				end,
				function( text ) end)
			rightadminmenu:Hide()
		end)
	end
	
	if gamemode.Get("jailbreak") then
		local tojbban = jbguardban:AddOption( v:Nick(), function()
			Derma_StringRequest( 
				"Guard Ban Reason", 
				"Why do you want to guard ban "..victimname.."?",
				"",
				function( text )
					Derma_StringRequest( 
						"Guard Ban Time", 
						"How long do you want to guard ban "..victimname.." (in minutes)?",
						"",
						function( text2 )
							RunConsoleCommand("notsosuper_guardban", tostring(victim), tostring(text2), tostring(text))
						end,
					function( text2 ) end)
				end,
			function( text ) end)
		end)
	
		local tofirewarden = firewarden:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_fire", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		local tojbswapteam = jbswapteam:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_swapteam", tostring(victim))
			rightadminmenu:Hide()
		end)
		
		local tojbspectator = jbspectator:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_spec", tostring(victim))
			rightadminmenu:Hide()
		end)
	elseif gamemode.Get("terrortown") then
		local todmgplylog = ttplydmglog:AddOption( v:Nick(), function()
			RunConsoleCommand("notsosuper_log", tostring(victim))
			rightadminmenu:Hide()
		end)
	end
	
	end
end
concommand.Add("notsosuper_admin", notsosuper_CMD_ADMINMENU)
