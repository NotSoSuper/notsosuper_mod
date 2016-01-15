if (!CLIENT) then return end

local function ChatText( pindex, pname, text, mess )
	if mess == "joinleave" then
		return true
	end
end
hook.Add( "ChatText", "Custom Disconnect Message", ChatText )
