This is a project to test dfPlayer fucntionality over the network.
Before use be sure that your module has been logged in to WiFi 
Write down its IP address. You will need it to send commands to ESP8266 module.

Files
1. init.lua
   Sets UART parameters an starts UDP Server
2. UDP_server
   Sets udp server on port 8266 and waits for the commands. The server generates a command call on cc.lua with the command received from the network.
   So if a the udp server receives a 0x01 commnd over the network it will generate a dofile("cc.lua").ply(0x01) on the UART side. 
3. cc.lua
   Is the command file to control dfPlayer module. Note that UARt command is moved to init.lua
