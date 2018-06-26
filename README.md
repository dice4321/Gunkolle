Gunkolle - Automated expedition checker 
--



```
>scripting
>kuso ttk
```

## Requirements: 

Running from source
* AHK (http://ahkscript.org/ or https://autohotkey.com/)
* Gdip_All library by tic (included)
* findclick libaray by berban (also included)
* playing at 1280 x 720 res

Running from releases (v1.60803 or above)
* None

THIS SCRIPT IS ONLY TESTED AND MAINTAINED ON WIN8.1 AND WIN10. I may be unable to help you on any other version.

## Features:

* Background scripting (cannot be minimized)
* Dynamic pixel checking to prevent user error
* Can be set up to pause/resume at a certain time
* All clicks have randomness to avoid click tracking
* can run for 24 hours, even skipping the daily login messages!

## How to use: Gunkolle
When starting Gunkolle make sure your android emulator is the active window when starting the script. (else you'll get an invald screen reading)

Dont do anything until you see the 'Ready' in the gui box.

If you are having probablems trying to get the 'Ready' on the home page, you can changing your nox graphics render settings from 'Compatible' to 'Speed'.

Click expedition only and leave window open in background.

If you are not playing with Nox, add/create an entry in the config.ini file in the script directory. Use AU3_Spy Window Spy that is included with your AHK installation to determine the window properties.  As shown below (Three valid options are show, **PICK ONE**)-

```
[Variables]
WINID=ahk_class Qt5QWindowIcon
WINID=ahk_exe Nox.exe
```

## How to use: Pause Utility

Simple pause script that runs alongside Gunkolle.

Enter in config.ini under [Variables], PauseHr=22 , and PauseMn=22 to pause at 22:22.  Use 24 Hour format only. You may use PCSleep=1 to sleep the computer at that time as well.

Use ResumeHr and ResumeMn to have the script resume at a specific time. Can be omitted for pause functionality only. When resume is enabled, PCSleep will be ignored and expired timers will automatically be set to pause/resume 24 hours later.
