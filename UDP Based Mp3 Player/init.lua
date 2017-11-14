print(wifi.sta.getip())


tmr.alarm(0, 1000, 0, function() 
print("start ok")
uart.setup(0, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1)
dofile("UDP_server.lua")

end )