# PS-SetWindowsPreferences

## Set optimized preferences for Windows 10/11 machines 

This program make some settings on the registry. Don't worry, the used commands optimized the Windows settings and do not crash the system.
In details the following changes will made:

* SSD optimization
  * Disable defragmatation
  * Disable hibernate option
  * Diable Prefetcher and Superfetch
  * Disable fast startup
  * Activate AHCI modus
  * Disable windows search indexing

* Engergy settings
  * Set monitor timeout to 0 for AC and DC
  * Set standby timeout to 0 for AC and DC
  * Only for notebooks: nothing will happen if the laptop will closed

* Windows activation
  * Rename the PC
  * Enter the Windows key
  * Strg + Alt + Del is needed for the login
 
* Datapolicy settings
  * Disable relevant ads for all users
  * Disable privacy settings experience
  * Send only the basic telemetry data
  * Disable the function that apps can activate by using the voice
  * Disable location service
  * Turn off the feature: Find my device

## Notifications

* The Windows setting fast start up can be the issue for some problems. Mostly is the best way to shutdown the system completly.
* Disable the Windows search indexing is better for the SSD.
* If you want to save some energy, its better to comment out line 65-72. On the other hand with this settings is nicer to work with the machine. The energy saver mode is also a good option to save energy.
* You have to buy a valid Windows version with a key. This code assume no liability if this is not the case.
* If you want to send Microsoft as little data as possible then are the data policty settings a good option for you.

## How the install the PS-SetWindowsPreferences tool

1. Clone this project
2. Edit the main.ps1 as following:
   - Set Debug to true if no actions should be made (only messages will apears, like WhatIf command in PowerShell)
   - Enter your new PC name (if you don't want: comment out line 80)
   - Enter you Windows key (if you don't want: comment out line 83-85)
3. Save the file main.ps after editing
4. Open a PowerShell script and run as **Administrator**
5. Navigate to you folder with "cd ~/downloads" for example (if the reposity is in the download folder)
6. Run the program with .\main.ps1 (in some case the parameter "-ExecutionPolicy RemoteSigned" have to add to this command)
