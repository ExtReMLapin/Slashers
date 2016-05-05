include("shared.lua");
include("sv_rounds.lua");
AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
AddCSLuaFile("client/hidden.lua");
AddCSLuaFile("client/postprocess.lua");
AddCSLuaFile("client/network.lua");
function GM:CanPlayerSuicide()
	return false
end

function GM:Initialize()
	
end

function GM:PlayerDisconnected( ply )
	self:PlayerDK(ply, 1)

end

function GM:PlayerDeath(ply, inflictor, attacker_ent)
	self:PlayerDK(ply, 2)
end

function GM:PlayerDeathThink()
	return false
end