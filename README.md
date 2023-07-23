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
  * Disable windows indexing

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

## How the install the PS-SetWindowsPreferences tool

1. Clone this project
2. Run the PowerShell script as Admin
