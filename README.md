
AHKanColle (Click script for KanColle expeditions)
--

by Ryuuhou

README 08/03/16

```
>scripting
>kuso ttk
```

## Requirements: 

Running from source
* AHK (http://ahkscript.org/ or https://autohotkey.com/)
* Gdip_All library by tic (included)

Running from releases (v1.60803 or above)
* None

THIS SCRIPT IS ONLY TESTED AND MAINTAINED ON WIN8.1 AND WIN10. I may be unable to help you on any other version.

## Features:

* Background scripting (cannot be minimized)
* Dynamic pixel checking to prevent user error
* Easy to use GUI with changeable settings
* Error Cat detection (script will be paused)
* Can be set up to pause/resume at a certain time
* All clicks have randomness to avoid click tracking
* Uses Windows notifications

## How to use: AHKanColle
Set which expedition each fleet will run, press ENTER to submit.  
Use expedition 0 to disable resending that fleet.

Enter a remaining time if it is currently already on an expedition. The following syntax are allowed for the time 2 hours 2 minutes and 2 seconds. 02:02:02 | 2:2:2 | 2h2m2s

If it is not on an expedition, use 0 to resupply and send after pushing the button "Send Expeditions."

Use a remaining time of -1 to disable scripting for that fleet.

Do not leave the fields blank.

Enter a MinWait and MaxWait in MILLISECONDS. The script will wait a random amount of time between these two numbers after an expedition comes back.

If you are not playing with KanColleViewer, add/create an entry in the config.ini file in the script directory. Use AutoIt3 Window Spy that is included with your AHK installation to determine the window properties.  As shown below (Three valid options are show, **PICK ONE**)-

```
[Variables]
WINID=艦隊これくしょん -艦これ- - オンラインゲーム - DMM.com - Mozilla Firefox
WINID=ahk_class MozillaWindowClass
WINID=ahk_exe firefox.exe
```

If using a browser, the name of window will usually be in the titlebar.

## How to use: Pause Utility

Simple pause script that runs alongside AHKanColle.

Enter in config.ini under [Variables], PauseHr=22 , and PauseMn=22 to pause at 22:22.  Use 24 Hour format only. You may use PCSleep=1 to sleep the computer at that time as well.

Use ResumeHr and ResumeMn to have the script resume at a specific time. Can be omitted for pause functionality only. When resume is enabled, PCSleep will be ignored and expired timers will automatically be set to pause/resume 24 hours later.

## How to use: AHKCSortie

Sortie script that should be used along with AHKanColle. GUI is pretty self explanatory.  Set the map you would like to script, set an interval if you would like it to automatically send again, and press start.
Currently, world 1, 3 and 5, maps 1, 2 and 4, are supported though only 1-1 (sparkling), 3-2 and 5-4 are recommended.  The script will check for critically damaged ships and resupply before each sortie. For sparkling, set #Nodes to 2 so the script continues to the next battle.

Some recommended intervals:
* 1000 for fatigue grinding
* 900000 for full morale recovery (recommended for 5-4)
* -1 to disable auto sending 

**I AM NOT RESPONSIBLE IF THIS SCRIPT BUGS AND SINKS YOUR SHIP. Use at your own risk.**

## FAQ:

#### The script gets stuck at "Waiting for homescreen..." or after hiding the UI, how do I fix this?
Do NOT use hardware acceleration on your browsers (KC Kai) or use "Direct/GPU" on KCV.

#### The script says invalid screen even though I am sitting on the HQ screen, what is going on?
No clue. For unknown reasons, the script sometimes starts unable to "see" the game window. Restart the script a few times, if this does not fix it, make sure the game is at High quality and 100% scale.

#### Why does the script take focus when it supposedly works in background?
Although this script was designed to work in background, certain applications may lose focus while scripting.

#### Can I minimize my browser/viewer while scripting?
Do NOT minimize browser/KCV, mouse clicks do not work while minimized. It can be behind other windows.

#### Why did the script send the wrong expedition?
If you have not unlocked all expeditions, your expeditions may be out of place and cause problems.  It is up to you to change the constants within the script if you wish to use it.

#### Can I play while scripting?
You may play when the script is idle. Playing while the script is running may lead to bugging the script.

#### Why is the script having issues clicking on my viewer?
If you are able to get the class name of the game frame (using Window Spy), you can specify a class name in config.ini.
For ElectronicObserver, Class=Internet Explorer_Server1 (shown below)
```
[Variables]
WINID=ahk_exe ElectronicObserver.exe
Class=Internet Explorer_Server1
```
Another option is to disable background clicking in the config.ini. See the bottom for a full list of config.ini settings.

##Config.ini
Many of these variables are OPTIONAL and will have default values, only WINID is mandatory. See "How to use: AHKanColle" for proper WINID format.
```
[Variables]
WINID=KanColleViewer!
//Name of the browser window/viewer that the script should script on.
Background=1
//Script attempts to click without losing focus from other windows. When set to 0, clicks are no longer done in background.  May fix issues with certain viewers.
Class=0
//When set to class name, i.e. Internet Explorer_Server1, the script will click directly on the class rather than the window.  May fix issues with certain applications. This setting is ignored if Background=0
NotificationLevel=1
//Uses Windows notifications to alert you of expeditions returning or sortie status.  Use a value of 0 to disable notifications.  Use a value of 2 for more detailed notifications.
DisableCriticalCheck=0
//When set to 1, AHKCSortie will not check for critical damage ONLY when "Start" is pressed. Sorties triggered by the interval will ALWAYS be checked.
DisableResupply=0
//When set to 1, AHKCSortie will not resupply ONLY when "Start" is pressed.  Sorties triggered by the interval will ALWAYS be resupplied.
PauseHr=22
PauseMn=22
//Pauses the script at 22:22 (24 hr format ONLY). Used for PauseUtility since there is no GUI for it. Set these first, then open pause utility.
PCSleep=0
//When set to 1, the script will attempt to put the computer to sleep when PauseUtility pauses the scripts.
iDOL=0
//When set to 1, the script will always idle on HQ screen (Mainly if you want to hear your secretary's hourlies). Yes, its a reference/play on words.
```