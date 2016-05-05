local offset = 0.00005
local metaplayer = FindMetaTable( "Player" )

function metaplayer:IsInDark()
	if not IsValid(self) then return false end
	local var = render.GetLightColor(self:GetPos()).x
	local speed = self:GetVelocity():Length()
	if var < offset  and speed < 60 and self:Crouching() then return true end
	return false, math.Max(0,math.Remap(var,0.001,offset,0,100))
end

function GM:DarkThink()
	--if not LocalPlayer().Class == CLASS_TYRONE then return end
	if not LocalPlayer().InDark and LocalPlayer():IsInDark() then LocalPlayer().InDark = true hook.Run("EnteredDark") return end
	if LocalPlayer().InDark and not LocalPlayer():IsInDark() then LocalPlayer().InDark = false hook.Run("LeftDark") return end
	return
end


hook.Add("EnteredDark", "darkprint", function() LocalPlayer():ChatPrint("entered zone") end)
hook.Add("LeftDark", "darkprint", function() LocalPlayer():ChatPrint("left zone") end)