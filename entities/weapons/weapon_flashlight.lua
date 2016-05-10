SWEP.ClassName = "weapon_flashlight";
SWEP.PrintName = "Flashlight";
SWEP.Author = GAMEMODE.Author;
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_item_maglite.mdl";
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_item_maglite.mdl";
SWEP.DrawAmmo = false;
SWEP.DrawCrosshair = false;
SWEP.Primary.Ammo = "none"
SWEP.Secondary.Ammo = "none";
SWEP.UseHands = true;
SWEP.HoldType = "slam";
SWEP.FlashlightIsOn = false;

function SWEP:Initialize()
	self:SetHoldType(self.HoldType);
end

function SWEP:Deploy()

end

function SWEP:Holster()

end

function SWEP:PrimaryAttack()
	return
end

function SWEP:SecondaryAttack()
	return
end