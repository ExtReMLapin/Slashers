include("shared.lua")
include("client/hidden.lua")
include("client/postprocess.lua")
include("client/network.lua")
function GM:Think()
	self:DarkThink()
end

local hidethings = { -- Yeah, i know its from original Gmod wiki , what do you think you think i will use something else ? Dont be dumb.
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true
}

