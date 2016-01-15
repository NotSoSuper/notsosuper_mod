if (!CLIENT) then return end

local ADMIN_COLOR = Color(100, 220, 80)

net.Receive( "AddText", function( len )
	args = net.ReadTable()
	chat.AddText( unpack( args ) )
end)

function notsosuper_MSG_CONNECTED(len)
	local name = net.ReadString()
	local steamid = net.ReadString()
	chat.AddText(Color(255, 255, 255), name.." [", Color(161, 255, 161), steamid, Color(255, 255, 255),"] connected.")
	chat.PlaySound()
end
net.Receive("notsosuper_MSG_CONNECTED",NOTSOSUPER_MSG_CONNECTED)

function notsosuper_MSG_DISCONNECTED(len)
	local name = net.ReadString()
	local steamid = net.ReadString()
	chat.AddText(Color(255, 255, 255), name.." [", Color(161, 255, 161), steamid, Color(255, 255, 255),"] disconnected.")
	chat.PlaySound()
end
net.Receive("notsosuper_MSG_DISCONNECTED",NOTSOSUPER_MSG_DISCONNECTED)

function notsosuper_MSG_PLY(len)
	local ply = net.ReadString()
	if LocalPlayer():Nick() != ply then return end
	local msg = net.ReadString()
	chat.AddText(Color(0, 255, 0), "[NotSoSuper] ", Color(255, 255, 255), msg)
	chat.PlaySound()
end
net.Receive("notsosuper_MSG_PLY",NOTSOSUPER_MSG_PLY)

function notsosuper_MSG_ALL(len)
	local action = net.ReadString()
	if(LocalPlayer():IsAdmin()) then
		local admin = net.ReadString()
		chat.AddText(Color(0, 255, 0),"[NotSoSuper] ", Color( 255, 255, 255 ), action, " by "..admin)
	else
		chat.AddText(Color(0, 255, 0),"[NotSoSuper] ", Color(255, 255, 255), action)
	end
	chat.PlaySound()
end
net.Receive("notsosuper_MSG_ALL",NOTSOSUPER_MSG_ALL)

function notsosuper_MSG_ADMINSAY(len)
	local notsosuper_VAR_MESSAGE = net.ReadString()
	if(LocalPlayer():IsAdmin()) then
		local notsosuper_VAR_ADMINNAME = net.ReadString()
		chat.AddText(Color(0, 255, 0),"(ALL) "..notsosuper_VAR_ADMINNAME..": ",Color( 255, 255, 255 ),NOTSOSUPER_VAR_MESSAGE)
	else
		chat.AddText(Color(0, 255, 0),"(ADMINS) ",notsosuper_VAR_MESSAGE)
	end
	chat.PlaySound()
end
net.Receive("notsosuper_MSG_ADMINSAY",NOTSOSUPER_MSG_ADMINSAY)

function notsosuper_MSG_ADMINS(len)
	if(LocalPlayer():IsAdmin()) then
		local action = net.ReadString()
		local admin = net.ReadString()
		chat.AddText(Color(0, 255, 0),"[NotSoSuper] ", Color( 255, 255, 255 ), admin, action)
	end
	chat.PlaySound()
end
net.Receive("notsosuper_MSG_ADMINS",NOTSOSUPER_MSG_ADMINS)

function notsosuper_MSG_ADMINCHAT(len)
	local notsosuper_VAR_ADMINNAME = net.ReadString()
	if(LocalPlayer():IsAdmin()) then
		local notsosuper_VAR_MESSAGE = net.ReadString()
		chat.AddText(Color( 0, 255, 0 ),"(ADMINS) "..notsosuper_VAR_ADMINNAME..": ",Color( 255, 255, 255 ),NOTSOSUPER_VAR_MESSAGE)
	elseif(LocalPlayer():Nick() == notsosuper_VAR_ADMINNAME) then
		chat.AddText(Color( 0, 255, 0 ),"(TO ADMINS) "..notsosuper_VAR_ADMINNAME..": ",Color( 255, 255, 255 ),NOTSOSUPER_VAR_MESSAGE)
	end
	chat.PlaySound()
end
net.Receive("notsosuper_MSG_ADMINCHAT",NOTSOSUPER_MSG_ADMINCHAT)

function notsosuper_MSG_ADMINPSAY(len)
	local notsosuper_VAR_ADMINNAME = net.ReadString()
	local notsosuper_VAR_NAME = net.ReadString()
	local notsosuper_VAR_MESSAGE = net.ReadString()
	if(LocalPlayer():Nick() == notsosuper_VAR_ADMINNAME) then
		chat.AddText(Color( 0, 255, 0 ),"(Private to "..notsosuper_VAR_NAME..")",Color( 255, 255, 255 )," "..NOTSOSUPER_VAR_MESSAGE)
	elseif (LocalPlayer():Nick() == notsosuper_VAR_NAME) then
		chat.AddText(Color( 0, 255, 0 ),"(Private from "..notsosuper_VAR_ADMINNAME..")",Color( 255, 255, 255 )," "..NOTSOSUPER_VAR_MESSAGE)
	end
	chat.PlaySound()
end
net.Receive("notsosuper_MSG_ADMINPSAY",NOTSOSUPER_MSG_ADMINPSAY)


local function AddDetectiveText(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		local tab = {}
		local default = Color(50, 200, 255)

		if IsValid(ply) then
			if ply:IsVIP() then
				table.insert( tab, ADMIN_COLOR )
				table.insert( tab, "[VIP] " )
			end

			local IsJunior = string.sub( ply:Name(), 1, 4 ) == "[NotSoSuper]"
			local IsMember = string.sub( ply:Name(), 1, 6 ) == "=[NotSoSuper]="

			if IsJunior then
				table.insert( tab, ADMIN_COLOR )
				table.insert( tab, "[NotSoSuper]" )
				table.insert( tab, default )
				table.insert( tab, string.sub( ply:Name(), 5 ) )
			elseif IsMember then
				table.insert( tab, default )
				table.insert( tab, "=" )
				table.insert( tab, ADMIN_COLOR )
				table.insert( tab, "[NotSoSuper]" )
				table.insert( tab, default )
				table.insert( tab, "=" )
				table.insert( tab, string.sub( ply:Name(), 7 ) )
			else
				table.insert( tab, ply )
			end
		end
	
		table.insert( tab, Color( 255, 255, 255 ) )
		table.insert( tab, ": " .. text )

		chat.AddText( unpack(tab) )
		return true
		
	elseif IsValid(ply) && ply:IsVIP() then
		local tab = {}
		
		if IsValid(ply)  then
			table.insert( tab, ADMIN_COLOR )
			table.insert( tab, "[VIP] " )
			table.insert( tab, ply )
		else
			table.insert( tab, "Console" )
		end
		
		table.insert( tab, Color( 255, 255, 255 ) )
		table.insert( tab, ": " .. text )
		
		chat.AddText( unpack(tab) )
		return true
	else
		chat.AddText(Color(50, 200, 255), ply:Nick(), Color(255,255,255), ": " .. text)
	end
	return false
end

local function tttChat( ply, strText, bTeamOnly, bPlayerIsDead )
	if IsValid(ply) and ply:IsActiveDetective() then
		AddDetectiveText(ply, strText)
		return true
	end
	
	if IsValid(ply) and ply:IsAdmin() then
	
		local tab = {}
		local default = team.GetColor( ply:Team() )

		if bPlayerIsDead then
			default = Color( 255, 30, 40 )
			table.insert( tab, Color( 255, 30, 40 ) )
			table.insert( tab, "*DEAD* " )
		end

		if bTeamOnly then
			table.insert( tab, Color( 30, 160, 40 ) )
			table.insert( tab, "(TEAM) " )
		end

		if IsValid( ply ) then
			if ply:IsVIP() then
				table.insert( tab, ADMIN_COLOR )
				table.insert( tab, "[VIP] " )
			end

			local IsJunior = string.sub( ply:Name(), 1, 4 ) == "[NotSoSuper]"
			local IsMember = string.sub( ply:Name(), 1, 6 ) == "=[NotSoSuper]="

			if IsJunior then
				table.insert( tab, ADMIN_COLOR )
				table.insert( tab, "[NotSoSuper]" )
				table.insert( tab, default )
				table.insert( tab, string.sub( ply:Name(), 5 ) )
			elseif IsMember then
				table.insert( tab, default )
				table.insert( tab, "=" )
				table.insert( tab, ADMIN_COLOR )
				table.insert( tab, "[NotSoSuper]" )
				table.insert( tab, default )
				table.insert( tab, "=" )
				table.insert( tab, string.sub( ply:Name(), 7 ) )
			else
				table.insert( tab, ply )
			end
		else
			table.insert( tab, "Console" )
		end
	
		table.insert( tab, Color( 255, 255, 255 ) )
		table.insert( tab, ": "..strText )

		chat.AddText( unpack(tab) )
		return true
		
	elseif IsValid(ply) && ply:IsVIP() then

		local tab = {}

		if bPlayerIsDead then
			table.insert( tab, Color( 255, 30, 40 ) )
			table.insert( tab, "*DEAD* " )
		end

		if bTeamOnly then
			table.insert( tab, Color( 30, 160, 40 ) )
			table.insert( tab, "(TEAM) " )
		end

		if IsValid( ply ) then
			table.insert( tab, ADMIN_COLOR )
			table.insert( tab, "[VIP] " )
			table.insert( tab, ply )
		else
			table.insert( tab, "Console" )
		end

		table.insert( tab, Color( 255, 255, 255 ) )
		table.insert( tab, ": " .. strText )

		chat.AddText( unpack(tab) )
		return true
	end
	return false
end

local function normalChat( ply, strText, bTeamOnly, bPlayerIsDead )
	if IsValid(ply) and ply:IsAdmin() then
	
		local tab = {}
		local default = team.GetColor( ply:Team() )

		if bPlayerIsDead then
			default = Color( 255, 30, 40 )
			table.insert( tab, Color( 255, 30, 40 ) )
			table.insert( tab, "*DEAD* " )
		end
		
		if bTeamOnly then
			table.insert( tab, Color( 30, 160, 40 ) )
			table.insert( tab, "(TEAM) " )
		end
		
		if IsValid( ply ) then
			if ply:IsVIP() then
				table.insert( tab, ADMIN_COLOR )
				table.insert( tab, "[VIP] " )
			end

			local IsJunior = string.sub( ply:Name(), 1, 4 ) == "[NotSoSuper]"
			local IsMember = string.sub( ply:Name(), 1, 6 ) == "=[NotSoSuper]="

			if IsJunior then
				table.insert( tab, ADMIN_COLOR )
				table.insert( tab, "[NotSoSuper]" )
				table.insert( tab, default )
				table.insert( tab, string.sub( ply:Name(), 5 ) )
			elseif IsMember then
				table.insert( tab, default )
				table.insert( tab, "=" )
				table.insert( tab, ADMIN_COLOR )
				table.insert( tab, "[NotSoSuper]" )
				table.insert( tab, default )
				table.insert( tab, "=" )
				table.insert( tab, string.sub( ply:Name(), 7 ) )
			else
				table.insert( tab, ply )
			end
		else
			table.insert( tab, "Console" )
		end
	
		table.insert( tab, Color( 255, 255, 255 ) )
		table.insert( tab, ": " .. strText )

		chat.AddText( unpack(tab) )
		return true
		
	elseif IsValid(ply) && ply:IsVIP() then
	
		local tab = {}

		if bPlayerIsDead then
			table.insert( tab, Color( 255, 30, 40 ) )
			table.insert( tab, "*DEAD* " )
		end

		if bTeamOnly then
			table.insert( tab, Color( 30, 160, 40 ) )
			table.insert( tab, "(TEAM) " )
		end

		if IsValid( ply ) then
			table.insert( tab, ADMIN_COLOR )
			table.insert( tab, "[VIP] " )
			table.insert( tab, ply )
		else
			table.insert( tab, "Console" )
		end

		table.insert( tab, Color( 255, 255, 255 ) )
		table.insert( tab, ": " .. strText )

		chat.AddText( unpack(tab) )
		return true
		
	end
	
	return false
end

local function bhChat( ply, strText, bTeamOnly, bPlayerIsDead )
	if IsValid(ply) && ply:IsAdmin() then
		local tab = {}
		local default = team.GetColor( ply:Team() )
		
		if bPlayerIsDead then
			table.insert( tab, Color( 255, 30, 40 ) )
			table.insert( tab, "*DEAD* " )
		end
		
		if bTeamOnly then
			table.insert( tab, Color( 30, 160, 40 ) )
			table.insert( tab, "(TEAM) " )
		end
		
		if IsValid( ply ) then
			if ply:IsVIP() then
				table.insert( tab, ADMIN_COLOR )
				table.insert( tab, "[VIP] " )
			end
			
			local RankID = ply:GetNetVar("BhopRank", 1)
			table.insert( tab, Color( 255, 255, 255 ) )
			table.insert( tab, "[" )
			table.insert( tab, GAMEMODE.RankList[RankID][2] )
			table.insert( tab, GAMEMODE.RankList[RankID][1] )
			table.insert( tab, Color( 255, 255, 255 ) )
			table.insert( tab, "] " )

			local IsJunior = string.sub( ply:Name(), 1, 4 ) == "[NotSoSuper]"
			local IsMember = string.sub( ply:Name(), 1, 6 ) == "=[NotSoSuper]="

			if IsJunior then
				table.insert( tab, ADMIN_COLOR )
				table.insert( tab, "[NotSoSuper]" )
				table.insert( tab, default )
				table.insert( tab, string.sub( ply:Name(), 5 ) )
			elseif IsMember then
				table.insert( tab, default )
				table.insert( tab, "=" )
				table.insert( tab, ADMIN_COLOR )
				table.insert( tab, "[NotSoSuper]" )
				table.insert( tab, default )
				table.insert( tab, "=" )
				table.insert( tab, string.sub( ply:Name(), 7 ) )
			else
				table.insert( tab, ply )
			end
		else
			table.insert( tab, "Console" )
		end

		table.insert( tab, Color( 255, 255, 255 ) )
		table.insert( tab, ": " .. strText )

		chat.AddText( unpack(tab) )
		return true
		
	elseif IsValid(ply) && ply:IsVIP() then
	
		local tab = {}

		if bPlayerIsDead then
			table.insert( tab, Color( 255, 30, 40 ) )
			table.insert( tab, "*DEAD* " )
		end
		
		if bTeamOnly then
			table.insert( tab, Color( 30, 160, 40 ) )
			table.insert( tab, "(TEAM) " )
		end
		
		if IsValid( ply ) then
			table.insert( tab, ADMIN_COLOR )
			table.insert( tab, "[VIP] " )

			local RankID = ply:GetNetVar("BhopRank", 1)
			table.insert( tab, Color( 255, 255, 255 ) )
			table.insert( tab, "[" )
			table.insert( tab, GAMEMODE.RankList[RankID][2] )
			table.insert( tab, GAMEMODE.RankList[RankID][1] )
			table.insert( tab, Color( 255, 255, 255 ) )
			table.insert( tab, "] " )
			
			table.insert( tab, ply )
		else
			table.insert( tab, "Console" )
		end
		
		table.insert( tab, Color( 255, 255, 255 ) )
		table.insert( tab, ": " .. strText )
		
		chat.AddText( unpack(tab) )
		return true
		
	else
		local tab = {}
		
		if bPlayerIsDead then
			table.insert( tab, Color( 255, 30, 40 ) )
			table.insert( tab, "*DEAD* " )
		end
		
		if bTeamOnly then
			table.insert( tab, Color( 30, 160, 40 ) )
			table.insert( tab, "(TEAM) " )
		end
		
		if IsValid( ply ) then
			local RankID = ply:GetNetVar("BhopRank", 1)
			table.insert( tab, Color( 255, 255, 255 ) )
			table.insert( tab, "[" )
			table.insert( tab, GAMEMODE.RankList[RankID][2] )
			table.insert( tab, GAMEMODE.RankList[RankID][1] )
			table.insert( tab, Color( 255, 255, 255 ) )
			table.insert( tab, "] " )
			
			table.insert( tab, ply )
		else
			table.insert( tab, "Console" )
		end
		
		table.insert( tab, Color( 255, 255, 255 ) )
		table.insert( tab, ": " .. strText )
		
		chat.AddText( unpack(tab) )
		return true
	end
end

function playerChat( ply, strText, bTeamOnly, bPlayerIsDead )
	--if tttChat(ply, strText, bTeamOnly, bPlayerIsDead) then 
	--	return true
	--end
	if bhChat(ply, strText, bTeamOnly, bPlayerIsDead) then
		return true
	end
	--if normalChat(ply, strText, bTeamOnly, bPlayerIsDead) then
	--	return true
	--end
end
hook.Add( "OnPlayerChat", "checkChat", playerChat )
