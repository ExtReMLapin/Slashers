include("shared.lua");
util.AddNetworkString("shl_endround")
util.AddNetworkString("shl_startround")
util.AddNetworkString("shl_warmupstart")
util.AddNetworkString("shl_waitingplayers")
SLASHERS.IsRoundActive = false;
SLASHERS.IsRoundBreak = false;
SLASHERS[game.GetMap()] = SLASHERS[game.GetMap()] or {};
SLASHERS.ROUND = {}
local ROUND = SLASHERS.ROUND
ROUND.ActualNumber = 0;
ROUND.BreakTime = 3;
ROUND.PlayTime = 5 * 60;
ROUND.StatShowTime = 3

--[[
**** Etapes : 
****	1 : Warmup ; 2 : Game 3 : Endgame où on show les stats 4 : Re-warmup etc...
--]]


function ROUND.Start()
	ROUND.Survivors = table.Copy(player.GetAll()) -- detour security
	SLASHERS.IsRoundActive = true;
	ROUND.ActualNumber = ROUND.ActualNumber + 1;
	local idklr = math.random(#ROUND.Survivors) -- id killer
	local Killer = ROUND.Survivors[idklr]
	ROUND.Survivors[idklr] = nil;
	local Spawnpoints = ents.FindByClass("info_player_counterterrorist");
	for Index, Player in pairs(ROUND.Survivors) do
		if Player ~= Killer then
			Player:KillSilent(); 
			Player:SetTeam(TEAM_SURVIVORS);
			Player:Spawn();
			Player:Give("weapon_flashlight");
			Player:SetNoCollideWithTeammates(false);
			Player:SetPos(table.Random(Spawnpoints):GetPos());
		end
	end
	if IsValid(Killer) then
		Killer:KillSilent(); 
		Killer:SetTeam(TEAM_KILLER);
		Killer:Spawn();
		Killer:Give(SLASHERS[game.GetMap()].Weapon or "weapon_357");
		Killer:SetNoCollideWithTeammates(false);
		Killer:SetPos(table.Random(ents.FindByClass("info_player_terrorist")):GetPos());
	end
	timer.Create("Round Playtime", (#ROUND.Survivors)*60, 1, function() ROUND.End(2) end );
	game.CleanUpMap(false);
	SLASHERS.SetUpClasses(Killer)
	-- TODO : add random inv
end

function ROUND.End(EndReason) --  all survivors are dead,no more time, killer left
	SLASHERS.IsRoundActive = false;
	SLASHERS.IsRoundBreak = 1;
	for Index, Player in pairs(player.GetAll()) do
		if IsValid(Player) then
			Player:KillSilent();
		end
	end
	net.Start("shl_endround")
	net.WriteBool(tobool(EndReason)) -- bool : killer lost ?
	net.Broadcast()
	timer.Simple(ROUND.StatShowTime, function() -- on show les stats, pas encore implanté
		ROUND.NewRound()
	end)
end


function ROUND.NewRound()
		SLASHERS.IsRoundBreak = 2;
		print("Warmup start")
		net.Start("shl_warmupstart")
		net.Broadcast()
		timer.Simple(ROUND.BreakTime, function()
			if #player.GetAll() >= 3 then
				SLASHERS.IsRoundBreak = false;
				print("sent")
				engine.LightStyle(0,"b")
				net.Start("shl_startround")
				net.Broadcast()
				ROUND.Start()
				return
			else
				print("No enough players")
				net.Start("shl_waitingplayers")
				net.Broadcast()
				timer.Create("WaitForPlayer", 1, 0, function()
					if #player.GetAll() >= 3 then
						SLASHERS.IsRoundBreak = false;
						print("sent")
						engine.LightStyle(0,"b")
						net.Start("shl_startround")
						net.Broadcast()
						ROUND.Start()
						return
					end
				end)
			end
	end)
end


function GM:PlayerSpawn(Player)
	if IsValid(Player) and not Player.InitialSpawnKilled then
		Player:KillSilent();
		Player.InitialSpawnKilled = true;
	end
	Player:SetupHands();
	if SLASHERS.IsRoundActive == false and SLASHERS.IsRoundBreak == false then
		if #player.GetAll() >= 3 then
			ROUND.NewRound()
		else
			print("No enough players")
			net.Start("shl_waitingplayers")
			net.Broadcast()
		end
	end

end

function GM:PlayerDK(ply, reason) -- Disconnect Killed 

	if not SLASHERS.IsRoundActive then return end
	if #ROUND.Survivors == 0 or (not ROUND.Survivors) then
		print("end")
		ROUND.End(1)
		return;
	end
	if ply:Team() == TEAM_SURVIVORS then
		for k, v in pairs(ROUND.Survivors) do
			if v == ply then
				ROUND.Survivors[k] = nil
			end
		end
	else
		ROUND.End(3);
		timer.Remove("Round Playtime");
	end
end
