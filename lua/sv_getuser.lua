if (!SERVER) then return end

function notsosuper_GLB_GETUSER(target)
	local players = player.GetAll()
	target = target:lower()

	local plyMatch
	
	-- First, do a full name match in case someone's trying to exploit our target system
	for _, player in ipairs( players ) do
		if target == player:Nick():lower() then
			if not plyMatch then
				return player
			else
				return false
			end
		end
	end
	
	for _, player in ipairs( players ) do
		local nameMatch
		if player:Nick():lower():find( target, 1, true ) then -- No patterns
			nameMatch = player
		elseif player:SteamID():lower() == target then
			nameMatch = player
		end
		if plyMatch and nameMatch then -- Already have one
			return false
		end
		if nameMatch then
			plyMatch = nameMatch
		end
	end

	if not plyMatch then
		return false
	end

	return plyMatch
end
