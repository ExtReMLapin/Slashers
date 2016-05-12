include("shared.lua");
util.AddNetworkString("shl_endround")
util.AddNetworkString("shl_startround")
util.AddNetworkString("shl_warmupstart")
util.AddNetworkString("shl_waitingplayers")
SLASHERS.IsRoundActive = SLASHERS.IsRoundActive or false;
SLASHERS.IsRoundBreak = SLASHERS.IsRoundBreak or false;
SLASHERS[game.GetMap()] = SLASHERS[game.GetMap()] or {};
SLASHERS.ROUND = SLASHERS.ROUND or {}
SLASHERS.ROUND.ActualNumber = 0;
SLASHERS.ROUND.BreakTime = 1;
SLASHERS.ROUND.PlayTime = 5 * 60;
SLASHERS.ROUND.StatShowTime = 1

--[[
**** Etapes : 
****	1 : Warmup ; 2 : Game 3 : Endgame où on show les stats 4 : Re-warmup etc...
--]]


function SLASHERS.ROUND.Start()
	SLASHERS.ROUND.Survivors = table.Copy(player.GetAll()) -- detour security
	SLASHERS.IsRoundActive = true;
	SLASHERS.ROUND.ActualNumber = SLASHERS.ROUND.ActualNumber + 1;
	local idklr = math.random(table.Count(SLASHERS.ROUND.Survivors)) -- id killer
	local Killer = SLASHERS.ROUND.Survivors[idklr]
	SLASHERS.ROUND.Survivors[idklr] = nil;
	local Spawnpoints = ents.FindByClass("info_player_counterterrorist");
	for Index, Player in pairs(SLASHERS.ROUND.Survivors) do
		if Player ~= Killer then
			Player:KillSilent(); 
			Player:SetTeam(TEAM_SURVIVORS);
			Player:Spawn();
			Player:Give("weapon_flashlight");
			Player:AllowFlashlight( true)
			Player.m_bTPFDisabled = false;
			Player:SetNoCollideWithTeammates(true);
			Player:SetPos(table.Random(Spawnpoints):GetPos());
		end
	end
	if IsValid(Killer) then
		Killer:KillSilent(); 
		Killer:SetTeam(TEAM_KILLER);
		Killer:Spawn();
		Killer.m_bTPFDisabled = true
		Killer:Give(SLASHERS[game.GetMap()].Weapon or "tfa_nmrih_machete");
		Killer:SetNoCollideWithTeammates(false);
		Killer:SetPos(table.Random(ents.FindByClass("info_player_terrorist")):GetPos());
	end
	timer.Create("Round Playtime", (table.Count(SLASHERS.ROUND.Survivors))*60, 1, function() SLASHERS.ROUND.End(2) end );
	game.CleanUpMap(false);
	print(1)
	PrintTable(SLASHERS.ROUND.Survivors)
	SLASHERS.SetUpClasses(Killer)
	-- TODO : add random inv
end

function SLASHERS.ROUND.End(EndReason) --  all survivors are dead,no more time, killer left
	SLASHERS.ROUND.Survivors = {}
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
	timer.Simple(SLASHERS.ROUND.StatShowTime, function() -- on show les stats, pas encore implanté
		SLASHERS.ROUND.NewRound()
	end)
end


function SLASHERS.ROUND.NewRound()
		SLASHERS.IsRoundBreak = 2;
		print("Warmup start")
		net.Start("shl_warmupstart")
		net.Broadcast()
		timer.Simple(SLASHERS.ROUND.BreakTime, function()
			if table.Count(player.GetAll()) >= 3 then
				SLASHERS.IsRoundBreak = false;
				print("sent")
				engine.LightStyle(0,"b")
				timer.Simple(0.1,function()
					net.Start("shl_startround")
					net.Broadcast()
					SLASHERS.ROUND.Start()
				end)
				return
			else
				print("No enough players")
				net.Start("shl_waitingplayers")
				net.Broadcast()
				timer.Create("WaitForPlayer", 1, 0, function()
					if table.Count(player.GetAll()) >= 3 then
						SLASHERS.IsRoundBreak = false;
						print("sent")
						engine.LightStyle(0,"b")
						timer.Simple(0.1,function()
							net.Start("shl_startround")
							net.Broadcast()
							SLASHERS.ROUND.Start()
						end)
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
		if table.Count(player.GetAll()) >= 3 then
			SLASHERS.ROUND.NewRound()
		else
			print("No enough players")
			net.Start("shl_waitingplayers")
			net.Broadcast()
		end
	end

end

function GM:PlayerDK(ply, reason) -- Disconnect Killed 
	if not SLASHERS.IsRoundActive then print("not active") return end
	if ply:Team() == TEAM_SURVIVORS then
		for k, v in pairs(SLASHERS.ROUND.Survivors) do
			if v == ply then
				print("killed one survivor")
				SLASHERS.ROUND.Survivors[k] = nil
			end
		end
	else
		SLASHERS.ROUND.End(3);
		timer.Remove("Round Playtime");
	end
	print("left survivors", table.Count(SLASHERS.ROUND.Survivors))
	if table.Count(SLASHERS.ROUND.Survivors) == 0 then
		print("no more survivirs")
		SLASHERS.ROUND.End(1)
		return;
	end


end
