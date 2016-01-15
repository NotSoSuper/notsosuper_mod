if (!CLIENT) then return end

local sprays = {}
local sprays2 = {}

net.Receive("notsosuper_NET_ADDSPRAY", function()
	local ply = net.ReadEntity()
	if ply.SteamID then
		local normal = Vector(net.ReadFloat(), net.ReadFloat(), net.ReadFloat())
		local ang = normal:Angle()
		local vec = ang:Forward() * .001 + (ang:Right() + ang:Up()) * 32
		local pos = Vector(net.ReadFloat(), net.ReadFloat(), net.ReadFloat()) + ang:Up() * 4
		sprays2[ply:SteamID()] = {name = ply:Name(), pos1 = pos - vec, pos2 = pos + vec, normal = normal, clears = 0, pos11 = pos - vec * 1.75, pos22 = pos + vec * 1.75}
	end
end)

local function isin(num, num1, num2)
	return (num >= num1 and num <= num2) or (num <= num1 and num >= num2)
end

hook.Add("PlayerBindPress", "SMNoSprayDelay", function(_, cmd, down)
	if down and string.find(cmd, "impulse 201") then
		local trace = LocalPlayer():GetEyeTrace()
		for k, v in pairs(sprays2) do
			if k ~= LocalPlayer():SteamID() and v.normal == trace.HitNormal and isin(trace.HitPos.x, v.pos11.x, v.pos22.x) and isin(trace.HitPos.y, v.pos11.y, v.pos22.y) and isin(trace.HitPos.z, v.pos11.z, v.pos22.z) then
				chat.AddText(Color(255, 255, 255), "You can't place your spray here.")
				return true
			end
		end
	end
end)

function CoverSpraysUp(len)
	sprays = nil
	sprays = net.ReadTable()
end
net.Receive("CoveredSprays",CoverSpraysUp)

function CoverSprayUp(len)
	local tab = net.ReadTable()
	table.insert(sprays,tab)
end
net.Receive("CoverSpray",CoverSprayUp)
	
function CoverSprays()
	cam.Start3D( EyePos(), EyeAngles() )
		for k,v in pairs(sprays) do
			local Pos = v[1]
			local Ang = v[2]
			Pos = Pos - (Ang:Forward()*2)
			render.SetMaterial(Material("tools/toolswhite"))
			render.DrawQuad(Pos-(Ang:Right()*50)+(Ang:Up()*50),Pos+(Ang:Right()*50)+(Ang:Up()*50),Pos+(Ang:Right()*50)-(Ang:Up()*50),Pos-(Ang:Right()*50)-(Ang:Up()*50))
		end
	cam.End3D()
end
hook.Add( "RenderScreenspaceEffects", "CoverSprays", CoverSprays )
