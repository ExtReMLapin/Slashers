net.Receive("shl_startround",function ()
	render.RedownloadAllLightmaps()
	LocalPlayer():ChatPrint("Start of round")
end)

net.Receive("shl_endround",function ()
	LocalPlayer():ChatPrint("End of round")
end)

net.Receive("shl_warmupstart",function ()
	LocalPlayer():ChatPrint("Warmup start")
end)

net.Receive("shl_waitingplayers",function ()
	LocalPlayer():ChatPrint("Waiting for players")
end)
