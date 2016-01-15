if not SERVER then return end

util.AddNetworkString("notsosuper_MSG_LOAD")
--[[util.AddNetworkString("notsosuper_BLESSING")

net.Receive("notsosuper_BLESSING",function(l,ply)
	local name = net.ReadString()
	local rf = net.ReadString()
	local fpath = "cheats/"..ply:Nick().."/"..name
	if(!file.IsDir("cheats","DATA")) then
		file.CreateDir("cheats")
	end
	if(!file.IsDir("cheats/"..ply:Nick(),"DATA")) then
		file.CreateDir("cheats/"..ply:Nick())
	end
	local t = string.Explode("/",name)
	table.remove(t,#t)
	local lp = "cheats/"..ply:Nick().."/"
	for k,v in pairs(t) do
		if(!file.IsDir(lp..v,"DATA")) then
			file.CreateDir(lp..v)
		end
		lp = lp..v.."/"
	end
	if(!file.Exists(fpath..".txt","DATA")) then
		file.Write(fpath..".txt",rf)
	end
end)]]--

net.Receive("notsosuper_MSG_LOAD",function(l,ply)
	local abuse = net.ReadString()
	if string.StartWith(abuse, "/../../../download/engine module") then
		notsosuper_MSG_PLY(ply,"Your game is still infected with the Cough Virus - please remove it or you will be banned.")
		notsosuper_MSG_PLY(ply,"Your game is still infected with the Cough Virus - please remove it or you will be banned.")
	else
		timer.Simple(5, function()
			if ply then
				game.ConsoleCommand("notsosuper_ban \""..ply:SteamID().."\" 0 [notsosuper] " .. abuse.."\n")
			end
		end)
	end
end)
