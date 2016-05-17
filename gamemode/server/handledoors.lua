local ENT = FindMetaTable("Entity")




----------------------------

function ENT:WoodenDoorInitialize()
	self.life = 500
	self.cent = math.floor(self.life/100)
end



function ENT:WoodenDoorState1(vec)
	local ang = self:GetAngles()
	local pos = self:GetPos()
	local enttemp1 = ents.Create( "prop_physics_multiplayer" )
	local enttemp2 = ents.Create( "prop_physics_multiplayer" )
	local enttemp3 = ents.Create( "prop_physics_multiplayer" )
	local enttemp4 = ents.Create( "prop_physics_multiplayer" )

	enttemp1:SetModel("models/props_doors/doormain_rural04_small_01.mdl")
	enttemp1:SetAngles(ang)
	enttemp1:SetPos(self:GetPos() )
	enttemp1:Spawn()
	enttemp1:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp1, self, 0, 0)
	enttemp2:SetModel("models/props_doors/doormain_rural04_small_02.mdl")
	enttemp2:SetAngles(ang)
	enttemp2:SetPos(self:GetPos() )
	enttemp2:Spawn()
	enttemp2:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp2, self, 0, 0)
	enttemp3:SetModel("models/props_doors/doormain_rural04_small_03.mdl")
	enttemp3:SetAngles(ang)
	enttemp3:SetPos(self:GetPos() )
	enttemp3:Spawn()
	enttemp3:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp3, self, 0, 0)
	enttemp4:SetModel("models/props_doors/doormain_rural04_small_04.mdl")
	enttemp4:SetAngles(ang)
	enttemp4:SetPos(self:GetPos() )
	enttemp4:Spawn()
	enttemp4:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp4, self, 0, 0)
	timer.Simple(12, 
		function() 
			if IsValid(enttemp1) then enttemp1:Remove() end
			if IsValid(enttemp2) then enttemp2:Remove() end
			if IsValid(enttemp3) then enttemp3:Remove() end 
			if IsValid(enttemp4) then enttemp4:Remove() end 
		end
	)

	self:Remove()
end

function ENT:WoodenDoorState2(vec)
	self:SetModel("models/props_doors/doormain_rural03_small_01.mdl")
	local enttemp1 = ents.Create( "prop_physics_multiplayer" )
	local enttemp2 = ents.Create( "prop_physics_multiplayer" )
	local ang = self:GetAngles()
	enttemp1:SetModel("models/props_doors/doormain_rural03_small_02.mdl")
	enttemp1:SetAngles(ang)
	enttemp1:SetPos(self:GetPos() )
	enttemp1:Spawn()
	enttemp1:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp1, self, 0, 0)

	enttemp2:SetModel("models/props_doors/doormain_rural03_small_03.mdl")
	enttemp2:SetAngles(ang)
	enttemp2:SetPos(self:GetPos() )
	enttemp2:Spawn()
	enttemp2:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp2, self, 0, 0)
	constraint.NoCollide(enttemp2, enttemp1, 0, 0)
	timer.Simple(6, function() if IsValid(enttemp1) then enttemp1:Remove() end  if IsValid(enttemp2) then enttemp2:Remove() end end)

end

function ENT:WoodenDoorState3(vec)
	self:SetModel("models/props_doors/doormain_rural02_small_01.mdl")
	local enttemp1 = ents.Create( "prop_physics_multiplayer" )
	local enttemp2 = ents.Create( "prop_physics_multiplayer" )
	local ang = self:GetAngles()
	enttemp1:SetModel("models/props_doors/doormain_rural02_small_02.mdl")
	enttemp1:SetAngles(ang)
	enttemp1:SetPos(self:GetPos() )
	enttemp1:Spawn()
	enttemp1:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp1, self, 0, 0)

	enttemp2:SetModel("models/props_doors/doormain_rural02_small_03.mdl")
	enttemp2:SetAngles(ang)
	enttemp2:SetPos(self:GetPos() )
	enttemp2:Spawn()
	enttemp2:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp2, self, 0, 0)
	constraint.NoCollide(enttemp2, enttemp1, 0, 0)
	timer.Simple(6, function() if IsValid(enttemp1) then enttemp1:Remove() end  if IsValid(enttemp2) then enttemp2:Remove() end end)


end

function ENT:WoodenDoorState4(vec)
	local enttemp = ents.Create( "prop_physics_multiplayer" )
	local ang = self:GetAngles()
	self:SetModel("models/props_doors/doormain_rural01_small_01.mdl")
	
	enttemp:SetModel("models/props_doors/doormain_rural01_small_02.mdl")
	enttemp:SetAngles(ang)
	enttemp:SetPos(self:GetPos() )
	enttemp:Spawn()
	enttemp:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp, self, 0, 0)
	timer.Simple(6, function() if IsValid(enttemp) then enttemp:Remove() end end)
end

function ENT:WoodenDoorOnTakeDamage(damage ) 
	local damageAmount = damage:GetDamage()
	self.life = self.life - damageAmount
	local vec;
	if IsValid(damage:GetAttacker()) and damage:GetAttacker():IsPlayer() then
		vec = damage:GetAttacker():GetAimVector()
	else
		vec = Vector(0,0,0)
	end
	if self.cent > math.floor(self.life/100) then
		self.cent = math.floor(self.life/100)
		if self.cent == 3 then self:WoodenDoorState4(vec) end
		if self.cent == 2 then self:WoodenDoorState3(vec) end
		if self.cent == 1 then self:WoodenDoorState2(vec) end
		if self.life < 50 then self:WoodenDoorState1(vec) end
	end
end

function ENT:MetalDoorState8(vec)
	self:SetModel("models/props_doors/doormainmetal01_dm01.mdl")
end

function ENT:MetalDoorState7(vec)
	self:SetModel("models/props_doors/doormainmetal01_dm02.mdl")
end

function ENT:MetalDoorState6(vec)
	self:SetModel("models/props_doors/doormainmetal01_dm03.mdl")

	local enttemp1 = ents.Create( "prop_physics_multiplayer" )
	local enttemp2 = ents.Create( "prop_physics_multiplayer" )
	local ang = self:GetAngles()
	enttemp1:SetModel("models/props_doors/doormainmetal01_dm03_a.mdl")
	enttemp1:SetAngles(ang)
	enttemp1:SetPos(self:GetPos() )
	enttemp1:Spawn()
	enttemp1:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp1, self, 0, 0)

	enttemp2:SetModel("models/props_doors/doormainmetal01_dm03_b.mdl")
	enttemp2:SetAngles(ang)
	enttemp2:SetPos(self:GetPos() )
	enttemp2:Spawn()
	enttemp2:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp2, self, 0, 0)
	constraint.NoCollide(enttemp2, enttemp1, 0, 0)
	timer.Simple(6, function() if IsValid(enttemp1) then enttemp1:Remove() end  if IsValid(enttemp2) then enttemp2:Remove() end end)
end
function ENT:MetalDoorState5(vec)
	self:SetModel("models/props_doors/doormainmetal01_dm04.mdl")
end

function ENT:MetalDoorState4(vec)
	self:SetModel("models/props_doors/doormainmetal01_dm05.mdl")

	local enttemp1 = ents.Create( "prop_physics_multiplayer" )
	local enttemp2 = ents.Create( "prop_physics_multiplayer" )
	local ang = self:GetAngles()
	enttemp1:SetModel("models/props_doors/doormainmetal01_dm05_a.mdl")
	enttemp1:SetAngles(ang)
	enttemp1:SetPos(self:GetPos() )
	enttemp1:Spawn()
	enttemp1:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp1, self, 0, 0)

	enttemp2:SetModel("models/props_doors/doormainmetal01_dm05_b.mdl")
	enttemp2:SetAngles(ang)
	enttemp2:SetPos(self:GetPos() )
	enttemp2:Spawn()
	enttemp2:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp2, self, 0, 0)
	constraint.NoCollide(enttemp2, enttemp1, 0, 0)
	timer.Simple(6, function() if IsValid(enttemp1) then enttemp1:Remove() end  if IsValid(enttemp2) then enttemp2:Remove() end end)
end

function ENT:MetalDoorState3(vec)
	self:SetModel("models/props_doors/doormainmetal01_dm06.mdl")

	local enttemp1 = ents.Create( "prop_physics_multiplayer" )
	local enttemp2 = ents.Create( "prop_physics_multiplayer" )
	local ang = self:GetAngles()
	enttemp1:SetModel("models/props_doors/doormainmetal01_dm06_a.mdl")
	enttemp1:SetAngles(ang)
	enttemp1:SetPos(self:GetPos() )
	enttemp1:Spawn()
	enttemp1:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp1, self, 0, 0)

	enttemp2:SetModel("models/props_doors/doormainmetal01_dm06_b.mdl")
	enttemp2:SetAngles(ang)
	enttemp2:SetPos(self:GetPos() )
	enttemp2:Spawn()
	enttemp2:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp2, self, 0, 0)
	constraint.NoCollide(enttemp2, enttemp1, 0, 0)
	timer.Simple(6, function() if IsValid(enttemp1) then enttemp1:Remove() end  if IsValid(enttemp2) then enttemp2:Remove() end end)
end

function ENT:MetalDoorState2(vec)
	self:SetModel("models/props_doors/doormainmetal01_dm07.mdl")

	local enttemp1 = ents.Create( "prop_physics_multiplayer" )
	local enttemp2 = ents.Create( "prop_physics_multiplayer" )
	local ang = self:GetAngles()
	enttemp1:SetModel("models/props_doors/doormainmetal01_dm07_a.mdl")
	enttemp1:SetAngles(ang)
	enttemp1:SetPos(self:GetPos() )
	enttemp1:Spawn()
	enttemp1:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp1, self, 0, 0)

	enttemp2:SetModel("models/props_doors/doormainmetal01_dm07_b.mdl")
	enttemp2:SetAngles(ang)
	enttemp2:SetPos(self:GetPos() )
	enttemp2:Spawn()
	enttemp2:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp2, self, 0, 0)
	constraint.NoCollide(enttemp2, enttemp1, 0, 0)
	timer.Simple(6, function() if IsValid(enttemp1) then enttemp1:Remove() end  if IsValid(enttemp2) then enttemp2:Remove() end end)
end

function ENT:MetalDoorState1(vec)
	local ang = self:GetAngles()
	local pos = self:GetPos()
	local enttemp1 = ents.Create( "prop_physics_multiplayer" )
	local enttemp2 = ents.Create( "prop_physics_multiplayer" )
	local enttemp3 = ents.Create( "prop_physics_multiplayer" )
	local enttemp4 = ents.Create( "prop_physics_multiplayer" )
	local enttemp5 = ents.Create( "prop_physics_multiplayer" )
	local enttemp6 = ents.Create( "prop_physics_multiplayer" )
	local enttemp7 = ents.Create( "prop_physics_multiplayer" )
	local enttemp8 = ents.Create( "prop_physics_multiplayer" )

	enttemp1:SetModel("models/props_doors/doormainmetal01_dm08_a.mdl")
	enttemp1:SetAngles(ang)
	enttemp1:SetPos(self:GetPos() )
	enttemp1:Spawn()
	enttemp1:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp1, self, 0, 0)
	enttemp2:SetModel("models/props_doors/doormainmetal01_dm08_a.mdl")
	enttemp2:SetAngles(ang)
	enttemp2:SetPos(self:GetPos() )
	enttemp2:Spawn()
	enttemp2:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp2, self, 0, 0)
	enttemp3:SetModel("models/props_doors/doormainmetal01_dm08_b.mdl")
	enttemp3:SetAngles(ang)
	enttemp3:SetPos(self:GetPos() )
	enttemp3:Spawn()
	enttemp3:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp3, self, 0, 0)
	enttemp4:SetModel("models/props_doors/doormainmetal01_dm08_c.mdl")
	enttemp4:SetAngles(ang)
	enttemp4:SetPos(self:GetPos() )
	enttemp4:Spawn()
	enttemp4:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp4, self, 0, 0)
	enttemp5:SetModel("models/props_doors/doormainmetal01_dm08_d.mdl")
	enttemp5:SetAngles(ang)
	enttemp5:SetPos(self:GetPos() )
	enttemp5:Spawn()
	enttemp5:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp5, self, 0, 0)
	enttemp6:SetModel("models/props_doors/doormainmetal01_dm08_f.mdl")
	enttemp6:SetAngles(ang)
	enttemp6:SetPos(self:GetPos() )
	enttemp6:Spawn()
	enttemp6:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp6, self, 0, 0)
	enttemp7:SetModel("models/props_doors/doormainmetal01_dm08_g.mdl")
	enttemp7:SetAngles(ang)
	enttemp7:SetPos(self:GetPos() )
	enttemp7:Spawn()
	enttemp7:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp7, self, 0, 0)
	enttemp8:SetModel("models/props_doors/doormainmetal01_dm08_h.mdl")
	enttemp8:SetAngles(ang)
	enttemp8:SetPos(self:GetPos() )
	enttemp8:Spawn()
	enttemp8:GetPhysicsObject():SetVelocity(vec*200)
	constraint.NoCollide(enttemp8, self, 0, 0)
	timer.Simple(12, 
		function() 
			if IsValid(enttemp1) then enttemp1:Remove() end
			if IsValid(enttemp2) then enttemp2:Remove() end
			if IsValid(enttemp3) then enttemp3:Remove() end 
			if IsValid(enttemp4) then enttemp4:Remove() end 
			if IsValid(enttemp5) then enttemp5:Remove() end
			if IsValid(enttemp6) then enttemp6:Remove() end
			if IsValid(enttemp7) then enttemp7:Remove() end 
			if IsValid(enttemp8) then enttemp8:Remove() end 
		end
	)

	self:Remove()
end


function ENT:MetalDoorOnTakeDamage(damage ) 
	local damageAmount = damage:GetDamage()

	self.life = self.life - damageAmount
	local vec;
	if IsValid(damage:GetAttacker()) and damage:GetAttacker():IsPlayer() then
		vec = damage:GetAttacker():GetAimVector()
	else
		vec = Vector(0,0,0)
	end
	if self.cent > math.floor(self.life/100) then
		self.cent = math.floor(self.life/100)
		if self.cent == 7 then self:MetalDoorState8(vec) end
		if self.cent == 6 then self:MetalDoorState7(vec) end
		if self.cent == 5 then self:MetalDoorState6(vec) end
		if self.cent == 4 then self:MetalDoorState5(vec) end
		if self.cent == 3 then self:MetalDoorState4(vec) end
		if self.cent == 2 then self:MetalDoorState3(vec) end
		if self.cent == 1 then self:MetalDoorState2(vec) end
		if self.life < 50 then self:MetalDoorState1(vec) end
	end
end

function ENT:MetalDoorInitialize()
	self.life = 800
	self.cent = math.floor(self.life/100)

end







local function prepareWooden(ent)
	ent:WoodenDoorInitialize()
	hook.Add("EntityTakeDamage", "doorwood" .. tostring(ent:GetCreationID()), function(ent2, dmg) if ent2 == ent then 	ent2:WoodenDoorOnTakeDamage(dmg ) end end)
end


local function prepareMetal(ent)
	ent:MetalDoorInitialize()
	hook.Add("EntityTakeDamage", "doormetal" .. tostring(ent:GetCreationID()), function(ent2, dmg) if ent2 == ent then ent2:MetalDoorOnTakeDamage(dmg ) end end)
end

function SLASHERS.handledoors()
	for k, v in pairs(hook.GetTable()["EntityTakeDamage"]) do
		hook.Remove("EntityTakeDamage", k)
	end

	for k, v in pairs(ents.GetAll()) do
		if v:GetClass() == "prop_door_rotating" then
			if v:GetModel() == "models/props_doors/doormain_rural01_small.mdl" then prepareWooden(v) end
			if v:GetModel() == "models/props_doors/doormainmetal01.mdl" then prepareMetal(v) end
		end
	end
end