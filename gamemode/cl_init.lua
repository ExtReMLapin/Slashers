include("shared.lua")
include("client/hidden.lua")
include("client/postprocess.lua")
include("client/network.lua")
function GM:Think()
	self:DarkThink()
end

local hide = {
	CHudHealth = true,
	CHudBattery = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end

	-- Don't return anything here, it may break other addons that rely on this hook.
end )