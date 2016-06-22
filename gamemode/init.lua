DEFINE_BASECLASS( "gamemode_base" )
include("shared.lua");
include("sv_rounds.lua");
include("server/class.lua")
include("server/light.lua")
include("server/handledoors.lua")
AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
AddCSLuaFile("client/hidden.lua");
AddCSLuaFile("client/postprocess.lua");
AddCSLuaFile("client/network.lua");
util.AddNetworkString("shl_firstspawn")
util.AddNetworkString("shl_flashlight")

GAME_LUM = "g"

pjs = pjs or {};

function GM:CanPlayerSuicide()
	return false
end

function GM:Initialize()
	timer.Simple(0,function()engine.LightStyle(0,GAME_LUM)end)
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

function GM:EntityTakeDamage( ent, info )

end


function GM:PlayerSwitchFlashlight( ply, state )
	if !ply:Alive() then return end
	if !pjs[ ply ] then
		SetupProjectedTexture( ply );
	else
		RemoveProjectedTexture( ply );
	end
	if !ply.m_bFLDisabled then
		net.Start("shl_flashlight")
		net.Send(ply)
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
