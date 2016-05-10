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