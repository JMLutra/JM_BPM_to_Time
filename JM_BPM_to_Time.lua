
--[[
	Usage:

	Lua "beatTime(master, beats, var)"
	
	master: Number of the Speedmaster
	beats: Number of beats of which you want the time
	var: Name of the GlobalVar to store the value in
	
	The value is stored as seconds.
--]]

function Main() 
	Echo("Not Implemented")
end

function calcBPM(obj)
	local percent = tonumber(obj:Get('normedvalue',Enums.Roles.Display))
	local bpm = 0
	local speedscale = obj:Get('speedscale',Enums.Roles.Display)
	if speedscale:match("Mul") then
		bpm = math.floor((((percent*0.17118)^1.907)*tonumber(speedscale:sub(4))) + 0.5)
	
	else if speedscale:match("Div") then
		bpm = math.floor((((percent*0.17118)^1.907)/tonumber(speedscale:sub(4))) + 0.5)
	else
		bpm = math.floor(((percent*0.17118)^1.907) + 0.5)
	end
	end
	return bpm
end

function beatTime(master, beats, var)
	local obj = GetObject("14.13.3."..master)
	local bpm = calcBPM(obj)
	local index = obj:Get('index',Enums.Roles.Display)
	SetVar(GlobalVars(), var, (60/bpm) * beats)
	return (60/bpm) * beats
end

return Main
