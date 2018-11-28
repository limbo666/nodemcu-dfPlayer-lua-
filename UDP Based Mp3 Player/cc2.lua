-- dfPlayer mini control by lua for use  with nodemcu
-- version 1.0 November 2017
-- Nikos Georgousis (georgousis.info)
-- Based on Yerke's original work for Arduino from https://forum.banggood.com/forum-topic-59997.html
-- User should pass only command and parameters(if needed). All the rest are calculated in the code
-- Play command: 					dofile("cc.lua").ply(0x0d)
-- Pause command: 					dofile("cc.lua").ply(0x0e)
-- Play file 5 on folder 1:		 	dofile("cc.lua").ply(0x0F,0x01,0x05)
-- Volume up: 						dofile("cc.lua").ply(0x04)
-- Volume down: 					dofile("cc.lua").ply(0x05)
-- Volume 20 (of 30 max): 			dofile("cc.lua").ply(0x06,0x00,0x14)
-- Select equalizer preset(Rock):	dofile("cc.lua").ply(0x07,0x00,0x02)
-- Play folder number 02:			dofile("cc.lua").ply(0x17,0x00,0x02)

--Serial communication setup 
--uart.setup(0, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1) -- You can move this line your project's init.lua file.
--Please notice that the above line will switch the communication interface to 9600 baud. Re-connect your programmer using the set baud rate. 

local PL
do
startb = 0x7e 	-- no change 
VER = 0xff		-- no change
Len = 0x06 		-- no change (always 6)
Feedback = 0x00	-- enable feedback or not
endb = 0xef		-- no change

function ply(InCMD) --changed to fix problem receiving when text commands via UDP Server 
	a = {} 
	i=0
	for word in string.gmatch(InCMD, '([^,]+)') do
		i= i+1
		a[i]=word
	end

	if a[2]~=nil then
	else
		a[2]=0x00 --load a zero
	end 

	if a[3]~=nil then
	else
		a[3]=0x00 --load a zero
	end 
	--print(a[1])
	--print(a[2])
	--print(a[3])
	--Ungly checksum calculation is following
	result = -(VER+Len+tonumber(a[1])+Feedback+tonumber(a[2])+tonumber(a[3]))
	output = string.format("%x", result * 256) 
	checksumpart1=("0x"..string.sub(output,3,4))
	checksumpart2=("0x"..string.sub(output,5,6))
	--Send the command to dfplayer module
	uart.write(0,tonumber(startb))
	uart.write(0,tonumber(VER))
	uart.write(0,tonumber(Len))
	uart.write(0,tonumber(a[1]))
	uart.write(0,tonumber(Feedback))
	uart.write(0,tonumber(a[2]))
	uart.write(0,tonumber(a[3]))
	uart.write(0,tonumber(checksumpart1))
	uart.write(0,tonumber(checksumpart2))
	uart.write(0,tonumber(endb))
end

PL={
ply=ply,
}
end
return PL