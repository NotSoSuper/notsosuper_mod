if (!CLIENT) then return end

-----------------------------------------
-----Made by JohnnyThunders (Loures)-----
-----------------------------------------

local FrameColor = Color(0, 0, 0, 0) --You can set your own frame color, remember to decrease the alpha value.
local ButtonColor = Color(0, 0, 0, 0) --You can set your own button color, remember to decrease the alpha value.

function OpenMOTDMenu()
	local MenuFrame = vgui.Create("DFrame")
	--MenuFrame.OPaint = MenuFrame.Paint
	MenuFrame:SetSize(ScrW() * 0.95, ScrH() * 0.95)
	MenuFrame:SetPos((ScrW() - MenuFrame:GetWide()) / 2, (ScrH() - MenuFrame:GetTall()) / 2)
	MenuFrame:SetTitle("Welcome to " .. GetHostName())
	MenuFrame:SetVisible(true)
	MenuFrame:SetDraggable(true)
	MenuFrame:ShowCloseButton(true)
	--MenuFrame.Paint = function()
	--	MenuFrame.OPaint(MenuFrame)
		surface.SetDrawColor(Color(60, 60, 60, 255))
		surface.DrawLine(1, MenuFrame:GetTall() - 27, MenuFrame:GetWide() - 1, MenuFrame:GetTall() - 27)
		draw.RoundedBox( 6, 0, 1, MenuFrame:GetWide(), MenuFrame:GetTall() + 1, FrameColor )
	--end
	MenuFrame:MakePopup()
	
	local CloseButton = vgui.Create("DButton", MenuFrame)
	--CloseButton.OPaint = CloseButton.Paint
	CloseButton:SetSize(150, 35)
	CloseButton:SetPos(MenuFrame:GetWide() * 0.75, MenuFrame:GetTall() - 27 - CloseButton:GetTall()/2)
	CloseButton:SetText("Ok, now let me play!")
	--CloseButton.Paint = function()
	--    CloseButton.OPaint(CloseButton)
	--   surface.DrawRect(1, 1, CloseButton:GetWide() - 2, CloseButton:GetTall() - 2)
	--end
	CloseButton.DoClick = function(button)
	MenuFrame:Close()
	end
	
	local MenuPSheet = vgui.Create("DPropertySheet", MenuFrame)
	MenuPSheet:SetPos(13, 30)
	MenuPSheet:SetSize(MenuFrame:GetWide() - 20, MenuFrame:GetTall() - 70)
	
	local Rules = vgui.Create( "HTML", MenuFrame )
	Rules:SetPos( 25, 50 )
	Rules:SetSize( 250, 250 )
	Rules:OpenURL("http://www.ropestore.org")
	
	--[[local TTTRules = vgui.Create( "HTML", MenuFrame )
	TTTRules:SetPos( 25, 50 )
	TTTRules:SetSize( 250, 250 )
	TTTRules:OpenURL("http://www.ropestore.org/index.php?pageid=tttrules")]]--
	
	--[[local JailRules = vgui.Create( "HTML", MenuFrame )
	JailRules:SetPos( 25, 50 )
	JailRules:SetSize( 250, 250 )
	JailRules:OpenURL("http://www.ropestore.org/index.php?pageid=gmjailrules")]]--
	
	local Donate = vgui.Create( "HTML", MenuFrame )
	Donate:SetPos( 25, 50 )
	Donate:SetSize( 250, 250 )
	Donate:OpenURL("http://www.ropestore.org")
	
	--You can add your own tabs down here
	/*EXAMPLE:
	local TabName = vgui.Create( "HTML", MenuFrame )
	TabName:SetPos( 25, 50 )
	TabName:SetSize( 250, 250 )
	--TabName:SetHTML([[]]) --use this for custom html code
	--TabName:OpenURL("") -- or this if you want to open an URL, remember that you must pick only one
	*/
	
	--You can chane the popup order here, or add your own tab!
	
	local order = {}
	order[1] = {"Code of Conduct", Rules, "icon16/information.png", false, false, "Code of Conduct"}
	--order[2] = {"Trouble in Terrorist Town Rules", TTTRules, "icon16/information.png", false, false, "Trouble in Terrorist Town Rules"}
	--order[2] = {"Jail Break Rules", JailRules, "icon16/information.png", false, false, "Jail Break Rules"}
	order[2] = {"Become a Supporter", Donate, "icon16/award_star_add.png", false, false, "Become a Supporter with VIP Benefits from only $5.00!"}
	
	for _, tab in pairs(order) do
		MenuPSheet:AddSheet(unpack(tab))
	end
end

concommand.Add("motd", OpenMOTDMenu)
