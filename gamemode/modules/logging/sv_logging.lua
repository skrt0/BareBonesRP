local function AdminLog(message, colour)
	local RF = RecipientFilter()
	for k,v in pairs(player.GetAll()) do
		local canHear = hook.Call("CanSeeLogMessage", GAMEMODE, v, message, colour)

		if canHear then
			RF:AddPlayer(v)
		end
	end
	umsg.Start("DRPLogMsg", RF)
		umsg.Short(colour.r)
		umsg.Short(colour.g)
		umsg.Short(colour.b) -- Alpha is not needed
		umsg.String(message)
	umsg.End()
end

local DarkRPFile
function DarkRP.log(text, colour)
	if colour then
		AdminLog(text, colour)
	end
	if (not GAMEMODE.Config.logging or not text) and not force then return end
	if not DarkRPFile then -- The log file of this session, if it's not there then make it!
		if not file.IsDir("DarkRP_logs", "DATA") then
			file.CreateDir("DarkRP_logs")
		end
		DarkRPFile = "DarkRP_logs/"..os.date("%m_%d_%Y %I_%M %p")..".txt"
		file.Write(DarkRPFile, os.date().. "\t".. text)
		return
	end
	file.Append(DarkRPFile, "\n"..os.date().. "\t"..(text or ""))
end
