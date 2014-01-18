These are some scripts that I use to burn codes on to the mote,listen on the serial port and create a new folder in the current folder with the required files for a new tinyos project.

Intructions:

	1. Burn
		To use this script. Type burn <mote number>.
		This changes the permission of the serial port and uploads the code to a telosb mote on the port /dev/ttyUSB0.
		You can configure the file based on your requirments.

	2. Listen
		To use this script. Type listen <0 or 1>.
		0 or 1 is for port /dev/ttyUSB0 or /dev/ttyUSB1 respectively.

	3. New TinyOS Project
		To use this script, Type tos-project\ <basename for your program>.
		To use this you need to have  null project from my repository in ~/tinyos-projects/null

	4. New TinyOS Project with send receive
		To use this script, Type tos-newproject <basename for your program>.
		To use this you need to have  basic_send_receive project from my repository in ~/tinyos-projects/basic_send_receive
		