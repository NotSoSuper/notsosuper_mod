if (!CLIENT) then return end

function Box(w, h, col)
	surface.SetDrawColor(col)
	surface.DrawRect(0, 0 , w, h)
	surface.SetDrawColor(255,255,255,5)
	surface.DrawRect(5, 2 , w - 10, h * 0.3)
	surface.SetDrawColor(color_black)
	surface.DrawOutlinedRect(0, 0, w, h)
end

net.Receive("notsosuper_NET_REQUESTSCREEN", function()
	local screen = {}
	screen.format = "jpeg"
	screen.h = ScrH()
	screen.w = ScrW()
	screen.quality = 0.05
	screen.x = 0
	screen.y = 0

	local data = render.Capture( screen )
	local Requestee = net.ReadEntity()
	
	net.Start("notsosuper_NET_GETSCREEN")
		net.WriteEntity(Requestee)
		net.WriteString( util.Base64Encode(data) )
	net.SendToServer()
end)

net.Receive("notsosuper_NET_SENDTOCALLER", function()
	local data = net.ReadString()

	local frame = vgui.Create("DFrame")
		frame:SetSize(ScrW() * 0.8, ScrH() * 0.8)
		frame:MakePopup()
		frame:Center()
		frame:SetTitle("Screenshot")
		frame.Paint = function()
			Box(frame:GetWide(), frame:GetTall(), Color(30,30,30,255))
		end

	local html = frame:Add("HTML")
		html:SetHTML([[
		<style type="text/css">
			body {
				margin: 0;
				padding: 0;
				overflow: hidden;
			}
			img {
				width: 100%;
				height: 100%;
			}
		</style>
		<img src="data:image/jpg;base64,]] .. data .. [[">]])
	html:Dock( FILL )
end)
