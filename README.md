﻿Gunkolle - Automated expedition checker 
--



```
>scripting
>kuso ttk
```

## Requirements: 

Running from source
* AHK (http://ahkscript.org/ or https://autohotkey.com/)
* Gdip_All library by tic (included)
* findclick library by berban (also included)
* Mouse library by fnzr (included)
* playing at 1280 x 720 res
* Requires a NVIDIA graphics card becuase of how NOX renders. [#16](https://github.com/dice4321/Gunkolle/issues/16)
* NOX version 6.1.0.0 recommended (6.0.8.0 version tends to crash with new NVIDIA drivers, 6.1.0.0 seems stable so far) 
* Default background in main menu

Running from releases (v1.60803 or above)
* None

THIS SCRIPT IS ONLY TESTED AND MAINTAINED ON WIN8.1 AND WIN10. I may be unable to help you on any other version.

## Features:

* Background scripting (cannot be minimized)
* Dynamic pixel checking to prevent user error
* Can be set up to pause/resume at a certain time
* All clicks have randomness to avoid click tracking
* can run for 24 hours, even skipping the daily login messages! [Not]

## What does not work at current state:
1. Auto-Factory
2. New day login

## How to use: Gunkolle(Expeditions)
When starting Gunkolle make sure your android emulator is the active window when starting the script. (else you'll get an invald screen reading)

Dont do anything until you see the 'Ready' in the gui box.

If you are having probablems trying to get the 'Ready' on the home page, you can changing your nox graphics render settings from 'Compatible' to 'Speed'.

Click expedition only and leave window open in background.

If you are not playing with Nox, add/create an entry in the config.ini file in the script directory. Use AU3_Spy Window Spy that is included with your AHK installation to determine the window properties.  As shown below (Two valid options are show, **PICK ONE**)-

```
[Variables]
WINID=ahk_class Qt5QWindowIcon
WINID=ahk_exe Nox.exe
```

## How to use: Gunkolle(Sortie)
read the wiki

![lol](https://github.com/dice4321/Gunkolle/blob/master/uselesspics/lol32.gif)

## How to use: Pause Utility

Simple pause script that runs alongside Gunkolle.

Enter in config.ini under [Variables], PauseHr=22 , and PauseMn=22 to pause at 22:22.  Use 24 Hour format only. You may use PCSleep=1 to sleep the computer at that time as well.

Use ResumeHr and ResumeMn to have the script resume at a specific time. Can be omitted for pause functionality only. When resume is enabled, PCSleep will be ignored and expired timers will automatically be set to pause/resume 24 hours later.
