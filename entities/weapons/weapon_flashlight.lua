SWEP.Base = "tfa_nmrimelee_base"
SWEP.Category = "TFA NMRIH"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.PrintName = "Maglite"

SWEP.ViewModel			= "models/weapons/tfa_nmrih/v_item_maglite.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50

SWEP.WorldModel			= "models/weapons/tfa_nmrih/w_item_maglite.mdl" --Viewmodel path
SWEP.HoldType = "knife"
SWEP.DefaultHoldType = "knife"
SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -0.5,
        Right = 2,
        Forward = 5.5,
        },
        Ang = {
        Up = -1,
        Right = 5,
        Forward = 178
        },
		Scale = 1.2
}

SWEP.Primary.Sound = Sound("Weapon_Melee.CrowbarLight")
SWEP.Secondary.Sound = Sound("Weapon_Melee.CrowbarHeavy")

SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed

SWEP.InspectPos = Vector(8.418, 0, 15.241)
SWEP.InspectAng = Vector(-9.146, 9.145, 17.709)

SWEP.Primary.Blunt = true
SWEP.Primary.Damage = 25
SWEP.Primary.Reach = 40
SWEP.Primary.RPM = 90
SWEP.Primary.SoundDelay = 0
SWEP.Primary.Delay = 0.3
SWEP.Primary.Window = 0.2

SWEP.Secondary.Blunt = true
SWEP.Secondary.RPM = 60 -- Delay = 60/RPM, this is only AFTER you release your heavy attack
SWEP.Secondary.Damage = 60
SWEP.Secondary.Reach = 40	
SWEP.Secondary.SoundDelay = 0.0
SWEP.Secondary.Delay = 0.2

SWEP.Secondary.BashDamage = 50
SWEP.Secondary.BashDelay = 0.35
SWEP.Secondary.BashLength = 40

SWEP.Callback = {}
SWEP.Callback.Initialize = function(self)

end
SWEP.Callback.Deploy = function(self)
	
end
SWEP.Callback.Holster = function(self)
	
end
SWEP.Callback.OnDrop = function(self)

end
SWEP.Callback.OnRemove = function(self)

end
SWEP.Callback.Think = function(self)

end


function SWEP:PrimaryAttack()

end

function SWEP:SecondaryAttack()

end

function SWEP:CalcViewModelView()
	if SERVER then return end
	if LocalPlayer():Team() == TEAM_SURVIVORS then
		local pjs = LocalPlayer():GetNWEntity( 'FL_Flashlight' )
		if IsValid( pjs ) then
			local bid = LocalPlayer():GetViewModel():LookupAttachment("light")
			local bp = LocalPlayer():GetViewModel():GetAttachment(bid)
			local ang = bp.Ang
			local pos = bp.Pos
			--ba:RotateAroundAxis(ba:Up(), -90)
			pjs:SetPos( pos +ang:Forward() * -5 );
			pjs:SetAngles( ang );
		end
	end
end