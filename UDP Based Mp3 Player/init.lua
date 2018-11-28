--init file for UDP Server based mp3 player
tmr.alarm(0, 1000, 0, function()  -- Start with a small delay just in case
	print("Starting. Switching to 9600 baud rate") -- Display message to inform about the change 
	uart.setup(0, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1) -- Switch baud to fit dfplayer interface
	print("\nCan you read this? - You're on 9600 baud rate") -- Verify that terminal is on correct baud rate (for diagnostic reasons)
		tmr.alarm(1, 2000, 0, function() -- A little later 
			dofile("UDP_server.lua") -- Start UDP Server
			print(wifi.sta.getip()) -- Display module's IP address
		end)
end )