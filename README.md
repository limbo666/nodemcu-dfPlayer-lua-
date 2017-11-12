dfPlayer mini control by lua 
===================================
Control dfPlayer mini devices from nodemcu based devices using their serial communication protocol.
dfPlayer mini is a low cost mp3 player whcih can be used in many appliactions. *More info about the hardware can be found on https://www.dfrobot.com/wiki/index.php/DFPlayer_Mini_SKU:DFR0299 *
The lack of standarized support on nodemcu was the motivation to create a simple file which send control commands to the device and can be re-used in any application.
This code helps developers to integrate mp3 modules easily to their project easily.

Command structure
===================================
The complete serial command structure is described in the device manual (http://www.picaxe.com/docs/spe033.pdf). User Yerke was a guy who took this info a bit further by testing most of these commnads under arduino environment and posted his result here https://forum.banggood.com/forum-topic-59997.html
In the current lua solution we are working on a solution similar to Yerke's proposed, allowing the user/ developer to call the commands by using only the command and parameters (if required).
This simplifies the development of devices and projects. Developer must add a **"dofile"** command to his code in order to send the requited commnd to the dfplayer.

A simple _play_ command can be executed like this: _**dofile("cc.lua").ply(0x0d)**_ 
or a command which requires parammeters can be called like this: _**dofile("cc.lua").ply(0x0F,0x01,0x05)**_
As you can see the only thing whic needs to be set is the hex commands in _.ply( )_.

How to use
===================================
Upload the lua file (cc.lua) to your module and then from any part of your project you can call the command you like to use.

**Examples are following**  
1. **Play command:**		 				_dofile("cc.lua").ply(0x0d)_
2. **Pause command:**			 			_dofile("cc.lua").ply(0x0e)_
3. **Play file 5 on folder 1:**			_dofile("cc.lua").ply(0x0F,0x01,0x05)_
4. **Volume up:** 							_dofile("cc.lua").ply(0x04)_
5.**Volume down:** 						_dofile("cc.lua").ply(0x05)_
6. **Volume 20 (of 30 max):** 				_dofile("cc.lua").ply(0x06,0x00,0x14)_
7. **Select equalizer preset(Rock):**		_dofile("cc.lua").ply(0x07,0x00,0x02)_
8. **Play all repeat** 					_dofile("cc.lua").ply(0x11,0x00,0x01)_
9. **Stop repeat player**					_dofile("cc.lua").ply(0x11,0x00,0x00)_

Commands supported
===================================
The commands can be found on dfPlayer manual, although there are some points where the comamnd descritpion is not clear enough.
*The following list is taken from Yerke's post on banggood forum. It contains only the a part of the commands supported if you want more info on this visit https://forum.banggood.com/forum-topic-59997.html*

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DF Player mini Commands without returned parameters (*=Confirmed command ?=Unknown, not clear or not validated)
CMD  CMD
HEX  DEC Function Description                  Parameters(2 x 8 bit)
==== === =================================== = ======================================================================
0x01   1 Next                                * [DH]=X, [DL]=X Next track in current folder.Loops when last file played
0x02   2 Previous                            * [DH]=X, [DL]=X Previous track in current folder.Loops when last file played
0x03   3 Specify track(NUM)                  * [DH]=highByte(NUM), [DL]=lowByte(NUM)
                                               1~2999 Playing order is order in which the numbers are stored.
                                               Filename and foldername are arbitrary, but when named starting with
                                               an increasing number and then placed in one folder, files are (often) 
                                               played in that order and with correct track number.
                                               e.g. 0001-Joe Jackson.mp3...0348-Lets dance.mp3)
0x04   4 Increase volume                     * [DH]=X, [DL]=X Increase volume by 1
0x05   5 Decrease volume                     * [DH]=X, [DL]=X Decrease volume by 1
0x06   6 Specify volume                      * [DH]=X, [DL]= Volume (0-0x30) Default=0x30
0x07   7 Specify Equalizer                   * [DH]=X, [DL]= EQ(0/1/2/3/4/5) [Normal/Pop/Rock/Jazz/Classic/Base]
0x08   8 Specify repeat(NUM)                 * [DH]=highByte(NUM), [DL]=lowByte(NUM).Repeat the specified track number
0x09   9 Specify playback source (Datasheet) ? [DH]=X, [DL]= (0/1/2/3/4)Unknown. Seems to be overrided by automatic detection
                                               (Datasheet: U/TF/AUX/SLEEP/FLASH)
0x0A  10 Enter into standby – low power loss * [DH]=X, [DL]=X Works, but no command found yet to end standby
                                               (insert TF-card again will end standby mode)
0x0B  11 Normal working (Datasheet)          ? Unknown. No error code, but no function found 
0x0C  12 Reset module                        * [DH]=X, [DL]=X Resets all (Track = 0x01, Volume = 0x30)
                                               Will return 0x3F initialization parameter (0x02 for TF-card)
                                               "Clap" sound after excecuting command (no solution found) 
0x0D  13 Play                                * [DH]=X, [DL]=X Play pointered track
0x0E  14 Pause                               * [DH]=X, [DL]=X Pause track
0x0F  15 Specify folder and file to playback * [DH]=Folder, [DL]=File
                                               Important: Folders must be named 01~99, files must be named 001~255 
0x10  16 Volume adjust set (Datasheet)       ? Unknown. No error code. Does not change the volume gain.
0x11  17 Loop play                           * [DH]=X, [DL]=(0x01:play, 0x00:stop play)
                                               Loop play all the tracks. Start at track 1.
0x12  18 Play mp3 file [NUM] in mp3 folder   * [DH]=highByte(NUM), [DL]=lowByte(NUM)
                                               Play mp3 file in folder named mp3 in your TF-card. File format exact
                                               4-digit number (0001~2999) e.g. 0235.mp3
0x13  19 Unknown                             ? Unknown: Returns error code 0x07
0x14  20 Unknown                             ? Unknown: Returns error code 0x06
0x15  21 Unknown                             ? Unknown: Returns no error code, but no function found                                              
0x16  22 Stop                                * [DH]=X, [DL]=X, Stop playing current track
0x17  23 Loop Folder "01"                    * [DH]=x, [DL]=1~255, Loops all files in folder named "01"
0x18  24 Random play                         * [DH]=X, [DL]=X Random all tracks, always starts at track 1
0x19  25 Single loop                         * [DH]=0, [DL]=0 Loops the track that is playing
0x1A  26 Pause                               * [DH]=X, [DL]=(0x01:pause, 0x00:stop pause)