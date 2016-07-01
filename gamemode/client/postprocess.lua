
local mat_ColorMod = Material( "pp/colour" )

mat_ColorMod:SetTexture( "$fbtexture", render.GetScreenEffectTexture() )

local tab = {}

function DrawColorModify( tab )

	tab[ "$pp_colour_addr" ] 		= 0.02
	tab[ "$pp_colour_addg" ] 		= 0.02
	tab[ "$pp_colour_addb" ] 		= 0.02
	if LocalPlayer():Team() == TEAM_KILLER then 
		tab[ "$pp_colour_brightness" ] 	= -0.02
		tab[ "$pp_colour_contrast" ] 	= 1.2
	else
		tab[ "$pp_colour_brightness" ] 	= -0.02
		tab[ "$pp_colour_contrast" ] 	= 1.2
	end 
	tab[ "$pp_colour_colour" ] 		= 1
	tab[ "$pp_colour_mulr" ] 		= 0.1
	tab[ "$pp_colour_mulg" ] 		= 0.1
	tab[ "$pp_colour_mulb" ] 		= 0.1

	render.UpdateScreenEffectTexture()

	for k, v in pairs( tab ) do
	
		mat_ColorMod:SetFloat( k, v )
		
	end

	render.SetMaterial( mat_ColorMod )
	render.DrawScreenQuad()
end

function GM:RenderScreenspaceEffects()
	DrawColorModify( tab )

end


hook.Add("HUDPaint", 'top kek engine calc', function() render.RedownloadAllLightmaps() hook.Remove("HUDPaint", 'top kek engine calc')end)