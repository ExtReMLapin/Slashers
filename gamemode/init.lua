include("shared.lua");
include("sv_rounds.lua");
include("server/class.lua")
include("server/light.lua")
AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
AddCSLuaFile("client/hidden.lua");
AddCSLuaFile("client/postprocess.lua");
AddCSLuaFile("client/network.lua");
util.AddNetworkString("shl_firstspawn")


pjs = pjs or {};

function GM:CanPlayerSuicide()
	return false
end

function GM:Initialize()
	engine.LightStyle(0,"b")
	timer.Simple(0,function()engine.LightStyle(0,"b")end)
end

function GM:PlayerDisconnected( ply )
	self:PlayerDK(ply, 1)
	if IsValid( pjs[ ply ] ) then
		SafeRemoveEntity( pjs[ ply ] )
		pjs[ ply ] = nil
	end
end

function GM:PlayerDeath(ply, inflictor, attacker_ent)
	self:PlayerDK(ply, 2)
end

function GM:PlayerDeathThink()
	return false
end

function GM:PlayerInitialSpawn(ply)
	net.Start("shl_firstspawn")
	net.Send(ply)
end


function GM:PlayerSwitchFlashlight( ply, state )
	if !ply:Alive() then return end
	if !pjs[ ply ] then
		TPF_SetupProjectedTexture( ply );
	else
		TPF_RemoveProjectedTexture( ply );
	end
	if !ply.m_bTPFDisabled then
		ply:SendLua( "surface.PlaySound( 'items/flashlight1.wav' )" );
	end
end 


function GM:Think()
	for i, ply in pairs( player.GetAll() ) do 
		if  IsValid( pjs[ ply ] ) then
			if SERVER then
			pjs[ ply ]:SetPos( ply:EyePos() + ply:GetAimVector() * 2 );
			pjs[ ply ]:SetAngles( ply:EyeAngles() );
			end
		end
	end


	if not SLASHERS.IsRoundActive then return end
	if SLASHERS.ROUND.Survivors and #SLASHERS.ROUND.Survivors == 0 then
		 SLASHERS.ROUND.End(1)
		return;
	end
end