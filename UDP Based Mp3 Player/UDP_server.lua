print("udp server")
udpport=2517
--UDP server for testing remote commands
udpSocket = net.createUDPSocket()
udpSocket:listen(udpport)
udpSocket:on("receive", function(s, data, port, ip)
	--print(string.format("'%s' from %s:%d", data, ip, port))
	s:send("2517", ip, "device: " .. data)
	--print(string.format("local UDP socket address / port: %s:%d", ip, port))
	print(data.."\n")
	--dofile("cc.lua").ply(data)
	-- print("C is "..c)
if data =="read" then
getTemp()
--elseif data =="read" then

end 
end)
port, ip = udpSocket:getaddr()
print("udp server started at port "..port)