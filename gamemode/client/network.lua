net.Receive("shl_startround",function ()
	render.RedownloadAllLightmaps()
	print("Start of round")
end)

net.Receive("shl_endround",function ()
	print("End of round")
end)

net.Receive("shl_warmupstart",function ()
	print("Warmup start")
end)

net.Receive("shl_waitingplayers",function ()
	print("Waiting for players")
end)


net.Receive("shl_firstspawn",function()
	render.RedownloadAllLightmaps()
end)

net.Receive("shl_flashlight",function()
	local pjs = LocalPlayer():GetNWEntity( 'FL_Flashlight' )
	if IsValid( pjs ) then
		if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() == "weapon_flashlight" then
			local bid = LocalPlayer():GetViewModel():LookupBone( "Maglite" )
			local bp, ba = LocalPlayer():GetViewModel():GetBonePosition( bid )
			ba:RotateAroundAxis(ba:Up(), -90)
			pjs:SetPos( bp +ba:Forward() * -3.5 );
			pjs:SetAngles( ba );
			pjs:SetParent(LocalPlayer():GetViewModel(), LocalPlayer():GetViewModel():LookupAttachment("light"))
			print(42)
		end
	end
end)


net.Receive("shl_entityupdate",function ()
	local ent = net.ReadEntity()
	ent:SetSolid(SOLID_VPHYSICS)
	ent:PhysicsInitShadow()
end)
