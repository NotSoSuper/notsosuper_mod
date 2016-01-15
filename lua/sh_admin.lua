local meta = FindMetaTable("Player")
function meta:IsAdmin()
	if(self:GetUserGroup() == "junior-admin" or self:GetUserGroup() == "member-admin" or self:GetUserGroup() == "advisor" or self:GetUserGroup() == "divmgr" or self:GetUserGroup() == "council") then return true end
	return false
end

function meta:IsVIP()
	if(self:GetNetVar("notsosuper_NET_VIP", false)) then return true end
	return false
end

function meta:IsRank()
	if(self:GetUserGroup() == nil) then return ""
	elseif(self:GetUserGroup() == "recruit") then return "-notsosuper-"
	elseif(self:GetUserGroup() == "junior" or self:GetUserGroup() == "junior-admin") then return "[NotSoSuper]"
	elseif(self:GetUserGroup() == "member" or self:GetUserGroup() == "member-admin" or self:GetUserGroup() == "advisor" or self:GetUserGroup() == "divmgr" or self:GetUserGroup() == "council") then return "=[NotSoSuper]=™"
	else return "" end
end

function meta:IsLeader()
	if(self:GetUserGroup() == "advisor" or self:GetUserGroup() == "divmgr" or self:GetUserGroup() == "council") then return true end
	return false
end
