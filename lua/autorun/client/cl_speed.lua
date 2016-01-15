if not CLIENT then return end

local ns = _G["net"]["Start"]
local nw = _G["net"]["WriteString"]
local ns2 = _G["net"]["SendToServer"]
local count = 0

local SCH = SysTime()
local RCH = RealTime()
local DiffSys
local DiffReal
local CCH = CurTime()

local function wat()
	if CurTime() >= CCH + 15 then count = 0 return end
	if count >= 16 then return end
	count = count + 1
	CCH = CurTime()
	if count >= 15 then
		ns("notsosuper_MSG_ASH")
		nw(count)
		ns2()
		return
	end
end

local function fSCH(SCH)
	ns("notsosuper_MSG_SCH")
	nw(SCH)
	ns2()
end

local function fRCH(RCH)
	ns("notsosuper_MSG_RCH")
	nw(RCH)
	ns2()
end

timer.Create("SC",5,0,function()
	DiffSys = SysTime() - SCH
	DiffReal = RealTime() - RCH
	if(DiffSys >= 5.08 and DiffReal >= 5.08) then
		wat()
		fSCH(DiffSys)
		fRCH(DiffReal)
	end
	SCH = SysTime()
	RCH = RealTime()
end)
