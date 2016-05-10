// ------------------------------------------------------------------- //
// -------------------- Third Person Flashlight ---------------------- //
// ------------------------------------------------------------------- //
// -------------------- By Wheatley ---------------------------------- //
// ------------------------------------------------------------------- //

util.AddNetworkString( 'TPF_UpdateClientLight' )
util.AddNetworkString( 'TPF_UpdateAllClientsLight' )
util.AddNetworkString( 'TPF_UpdateServerLimits' )

function TPF_SetupProjectedTexture( ply )
	print("CALLED ONE")
	if ply.m_bTPFDisabled then return end
	pjs[ ply ] = ents.Create( "env_projectedtexture" );
	pjs[ ply ]:SetPos( ply:EyePos() );
	pjs[ ply ]:SetAngles( ply:EyeAngles() );
	pjs[ ply ].SHD = 1;
	pjs[ ply ]:SetKeyValue( "enableshadows", 1 );
	pjs[ ply ].FARZ = 1477;
	pjs[ ply ]:SetKeyValue( "farz", 1477 );
	pjs[ ply ]:SetKeyValue( "nearz", 10 );
	pjs[ ply ].FOV = 75;
	pjs[ ply ]:SetKeyValue( "lightfov", 75 );
	pjs[ ply ].Bright = 663;
	pjs[ ply ].R = 56;
	pjs[ ply ].G = 255;
	pjs[ ply ].B = 255;
	pjs[ ply ]:SetKeyValue( "lightcolor", "56 255 255 255" );
	pjs[ ply ]:Spawn()
	pjs[ ply ].Mat = ply:GetNWString( "effects/flashlight001" );
	pjs[ ply ]:Input( "SpotlightTexture", NULL, NULL, "effects/flashlight001" )
	ply:SetNWEntity( 'TPF_Flashlight', pjs[ ply ] )
end

function TPF_RemoveProjectedTexture( ply )
	if pjs[ ply ] then
		ply:SetNWEntity( 'TPF_Flashlight', NULL )
		timer.Remove( 'tpf_apptypes_' .. ply:EntIndex() )
		SafeRemoveEntity( pjs[ ply ] );
		pjs[ ply ] = nil;
	end
end

function TPF_Update()
	for i, ply in pairs( player.GetAll() ) do
		if !ply:Alive() and pjs[ ply ] then TPF_RemoveProjectedTexture( ply ); end
		ply:AllowFlashlight( false )
	end
end

timer.Create( 'tpf_update', 1, 0, function()
	TPF_Update();
end )