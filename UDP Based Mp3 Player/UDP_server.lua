
--UDP server for testing remote commands
udpSocket = net.createUDPSocket()
udpSocket:listen(8266)
udpSocket:on("receive", function(s, data, port, ip)
-- print(string.format("'%s' from %s:%d", data, ip, port))
--s:send(port, ip, "echo: " .. data)
--print(string.format("local UDP socket address / port: %s:%d", ip, port))
c=data
print(data.."\n")
dofile("cc.lua").ply(data)
  -- print("C is "..c)
end)
port, ip = udpSocket:getaddr()