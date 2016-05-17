function SetupProjectedTexture( ply )
	if ply.m_bFLDisabled then return end
	pjs[ ply ] = ents.Create( "env_projectedtexture" );
	pjs[ ply ]:SetLagCompensated(true)
	pjs[ ply ]:SetPos( ply:EyePos() );
	pjs[ ply ]:SetAngles( ply:EyeAngles() );
	pjs[ ply ]:SetKeyValue( "enableshadows", 1 );
	pjs[ ply ]:SetKeyValue( "farz", 1477 );
	pjs[ ply ]:SetKeyValue( "nearz", 10 );
	pjs[ ply ]:SetKeyValue( "lightfov", 45 );
	pjs[ ply ]:SetKeyValue( "lightcolor", "100 255 255 255" );
	pjs[ ply ]:Spawn()
	pjs[ ply ]:Input( "SpotlightTexture", NULL, NULL, "effects/flashlight001" )
	ply:SetNWEntity( 'FL_Flashlight', pjs[ ply ] )
end

function RemoveProjectedTexture( ply )
	if pjs[ ply ] then
		ply:SetNWEntity( 'FL_Flashlight', NULL )
		SafeRemoveEntity( pjs[ ply ] );
		pjs[ ply ] = nil;
	end
end

timer.Create( 'fl_update', 1, 0, function()
	for i, ply in pairs( player.GetAll() ) do
		if !ply:Alive() and pjs[ ply ] then RemoveProjectedTexture( ply ); end
		ply:AllowFlashlight( false )
	end
end )