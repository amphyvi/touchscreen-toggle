# touchscreentoggle
Solution for artists to toggle touchscreens on/off on Windows computers.

---------------

I use a Windows laptop for general computing *and* for drawing. I don't want to use a glove to keep from causing unwanted inputs. Disabling touch in specific apps (such as Clip Studio Paint) using the app's settings helps, but doesn't solve the issue.

This is a PowerShell script, that you can set up to be a program you can pin/shortcut using the instructions below*, that will check for any touchscreen devices on your computer and either disable them (if enabled) or enable them (if disabled). Think of this as a digital "light switch" but for the touchscreen functionality on your computer. In my testing, this disables the *touchscreen* for finger touch, but not the *digitizer* for drawing, so it's perfect for my needs. I haven't seen any reliable solutions for this out in the wild so... here's one now.

# Using as a script (inconvenient, requires no setup)
Start by downloading `Toggle-Touchscreen.ps1`. Then...
1. Find the .ps1 file, wherever you keep it on your computer.
2. Right-click it, choose Run With PowerShell.
3. Approve when prompted (you may need to enter your password!).

That's it! Your touchscreen should be disabled or enabled accordingly. Unfortunately, you have to do this every single time you want to toggle your touchscreen, so it may get kind of grating after a while - that's where using it as a program comes in.

# Using as a program (convenient, requires some setup)
\* I don't feel comfortable distributing .exe files, even though I obviously have no ill intent. They require blind trust and open the door to malicious activity. So, please follow these steps to create a very handy touchscreen toggle program.

Start by downloading `Toggle-Touchscreen-nocheck.ps1`. Then...
1. Install PS2EXE via an administrator PowerShell instance, using these instructions: https://github.com/MScholtes/PS2EXE?tab=readme-ov-file#installation (keep the administrator PowerShell instance open when following the next steps too)
2. In PowerShell, type the following, and (in the quotes) **type the path of the `Toggle-Touchscreen-nocheck.ps1` you downloaded**. Press Enter once you've got it.
```powershell
# EXAMPLE: $input = "C:\Users\amphy\Downloads\Toggle-Touchscreen-nocheck.ps1"
$inFile = ""
```
3. Next, type the following, and (in the quotes) **type the full path and name of where you want the EXE to end up**. Press Enter when finished.
```powershell
# EXAMPLE: $output = "C:\Temp\Toggle-Touchscreen.exe" (be sure to include the .exe in the filename!)
$outExe = ""
```
4. Lastly, just run this and you'll end up with an EXE file where you specified in the previous step!
```powershell
Invoke-ps2exe $inFile $outExe
```

This will get you most of the way. Now, you can pin that EXE to your Start menu or taskbar, or create a shortcut to it, and you can now use it to toggle your touchscreen... **but, you must make it run as Administrator** or you'll get a "generic error" each time and it won't work. Use A or B below to accomplish that.

A. If you don't mind the admin prompt, even if that means you may need to enter your password each time...
- Hold Shift and right-click the pin/shortcut you created, and choose Properties. (If you don't see Properties, use Open File Location instead to see where the pin is located, then use *that* when repeating this step)
- Go to the Compatibility tab, and enable the **Run this program as an administrator** checkbox.

B. If you would rather it be as seamless as possible, and don't want the admin prompt each time... then follow these (kind of technical, but very helpful) steps: https://superuser.com/a/1854880

That's it! Now you can use the pin/shortcut you created, and even customize it with an icon etc, and you'll be able to toggle your touchscreen on or off extremely quickly and extremely easily.
