if (!SERVER) then return end

net.Receive("notsosuper_NET_GETSCREEN", function()
	local caller = net.ReadEntity()
	local data = net.ReadString()
	if caller:IsAdmin() then
		net.Start("notsosuper_NET_SENDTOCALLER")
			net.WriteString( data )
		net.Send(caller)
	end
end)
