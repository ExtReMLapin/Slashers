local metaplayer = FindMetaTable( "Player" )
util.AddNetworkString("shl_newclass")


CLASS_FLASH = 1;
CLASS_NICK	= 2;
CLASS_KIMBERLY = 3;
CLASS_GARRY = 4;
CLASS_SAM = 5;
CLASS_TYRONE = 6;

SLASHERS.Survivors = {}

SLASHERS.Survivors[CLASS_FLASH] = {}
SLASHERS.Survivors[CLASS_FLASH].name = "Flash"
SLASHERS.Survivors[CLASS_FLASH].desc = "The big guy"
SLASHERS.Survivors[CLASS_FLASH].walkspeed = 150
SLASHERS.Survivors[CLASS_FLASH].runspeed = 200
SLASHERS.Survivors[CLASS_FLASH].life = 130
SLASHERS.Survivors[CLASS_FLASH].stamina = 120;

SLASHERS.Survivors[CLASS_NICK] = {}
SLASHERS.Survivors[CLASS_NICK].name = "Nick"
SLASHERS.Survivors[CLASS_NICK].desc = "The nerd"
SLASHERS.Survivors[CLASS_NICK].walkspeed = 160
SLASHERS.Survivors[CLASS_NICK].runspeed = 215
SLASHERS.Survivors[CLASS_NICK].life = 80
SLASHERS.Survivors[CLASS_NICK].stamina = 60;
SLASHERS.Survivors[CLASS_NICK].model = "models/h-d/2sg/simonplayer.mdl"

SLASHERS.Survivors[CLASS_KIMBERLY] = {}
SLASHERS.Survivors[CLASS_KIMBERLY].name = "Kimberly"
SLASHERS.Survivors[CLASS_KIMBERLY].desc = "The popular girl"
SLASHERS.Survivors[CLASS_KIMBERLY].walkspeed = 175
SLASHERS.Survivors[CLASS_KIMBERLY].runspeed = 225
SLASHERS.Survivors[CLASS_KIMBERLY].life = 70
SLASHERS.Survivors[CLASS_KIMBERLY].stamina = 100;

SLASHERS.Survivors[CLASS_GARRY] = {}
SLASHERS.Survivors[CLASS_GARRY].name = "Garry"
SLASHERS.Survivors[CLASS_GARRY].desc = "The fat boy"
SLASHERS.Survivors[CLASS_GARRY].walkspeed = 100
SLASHERS.Survivors[CLASS_GARRY].runspeed = 150
SLASHERS.Survivors[CLASS_GARRY].life = 150
SLASHERS.Survivors[CLASS_GARRY].stamina = 100;
SLASHERS.Survivors[CLASS_GARRY].model = "models/gaben/gabe_3.mdl"


SLASHERS.Survivors[CLASS_SAM] = {}
SLASHERS.Survivors[CLASS_SAM].name = "Sam"
SLASHERS.Survivors[CLASS_SAM].desc = "The shy girl"
SLASHERS.Survivors[CLASS_SAM].walkspeed = 170
SLASHERS.Survivors[CLASS_SAM].runspeed = 220
SLASHERS.Survivors[CLASS_SAM].life = 50
SLASHERS.Survivors[CLASS_SAM].stamina = 120;
SLASHERS.Survivors[CLASS_SAM].model = "models/player/ow_tracer.mdl"

SLASHERS.Survivors[CLASS_TYRONE] = {}
SLASHERS.Survivors[CLASS_TYRONE].name = "Tyrone"
SLASHERS.Survivors[CLASS_TYRONE].desc = "The first to die"
SLASHERS.Survivors[CLASS_TYRONE].walkspeed = 150
SLASHERS.Survivors[CLASS_TYRONE].runspeed = 240
SLASHERS.Survivors[CLASS_TYRONE].life = 100
SLASHERS.Survivors[CLASS_TYRONE].stamina = 120;
SLASHERS.Survivors[CLASS_TYRONE].model = "models/player/cj.mdl"

local tmptbl1 = {CLASS_FLASH, CLASS_NICK, CLASS_KIMBERLY, CLASS_GARRY, CLASS_SAM, CLASS_TYRONE}
local tmptbl2 = table.Copy(tmptbl1)

function metaplayer:SetClass(n)
		print(Format("Player %s is set to class %s", self:Nick(), SLASHERS.Survivors[n].name))
		self:SetWalkSpeed(SLASHERS.Survivors[n].walkspeed)
		self:SetRunSpeed(SLASHERS.Survivors[n].runspeed)
		self:SetMaxHealth(SLASHERS.Survivors[n].life)
		self:SetNWInt("MaxHealth",SLASHERS.Survivors[n].life)
		self:SetNWInt("MaxStamina",SLASHERS.Survivors[n].stamina)
		self:SetNWInt("ClassID",n)
		if SLASHERS.Survivors[n].model then 
			self:SetModel(SLASHERS.Survivors[n].model)
		else
			self:SetModel("models/player/eli.mdl")
		end
end


function SLASHERS.SetUpClasses(killer)
	tmptbl2 = table.Copy(tmptbl1)
	for k,ply in pairs(SLASHERS.ROUND.Survivors) do
		if #tmptbl2 == 0 or not tmptbl2 then
			print("max classes") 
			ply:SetClass(table.Random(tmptbl1))
			return
		end
		local n = table.Random(tmptbl2)

		ply:SetClass(n)
		tmptbl2[n] = nil
	end

	killer:SetMaxHealth(100)
	killer:SetNWInt("MaxHealth",100)
	killer:SetNWInt("MaxStamina",150)
	killer:SetNWInt("ClassID",0)
	killer:SetWalkSpeed(150)
	killer:SetRunSpeed(260)
	killer:SetModel("models/player/eli.mdl")
	net.Start("shl_newclass")
	net.Broadcast()
end