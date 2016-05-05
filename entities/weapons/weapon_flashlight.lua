SWEP.ClassName = "weapon_flashlight";
SWEP.PrintName = "Flashlight";
SWEP.Author = GAMEMODE.Author;
SWEP.ViewModel = "models/weapons/c_flashlight_zm.mdl";
SWEP.WorldModel = "models/weapons/w_flashlight_zm.mdl";
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
	if SERVER and not IsValid(self.Flashlight) then
		self.Flashlight = ents.Create("env_projectedtexture");
		self.Flashlight:SetParent(self.Owner:GetViewModel());
		self.Flashlight:Fire("SetParentAttachment", "light");
		self.FlashlightIsOn = true;
	end
end

function SWEP:Holster()
	if SERVER and IsValid(self.Flashlight) then
		self.Flashlight:Remove();
	end
	return true
end

function SWEP:PrimaryAttack()
	return
end

function SWEP:SecondaryAttack()
	return
end