<p align="center"><img width="65" height="65" alt="Touchscreen-Toggle icon" src="https://github.com/user-attachments/assets/c1dfa607-4ab9-460d-ba0f-d7781f26dc28" /></p>

# Touchscreen-Toggle

Solution for artists to quickly and easily turn on/off the touchscreen on Windows computers, without affecting stylus (digitizer) input.


---------------

I use a Windows laptop for general computing *and* for drawing. I don't want to have to remember to use a special glove when drawing just to avoid unwanted touch inputs. "Disabling" touch in specific apps in their settings (such as Clip Studio Paint) helps a little, but modern displays have really tiny bezels which leads to lots of unintentional palm touches at every edge, so it doesn't help much.

Looking around online, I couldn't find any good solutions for this on Windows computers. I'm sure Linux has a few tricks up its sleeves, but I intentionally don't use that on my laptop since it doesn't suit my needs. So, hopefully this solution will solve it for everyone drawing on a portable Windows computer like I am.

There's a PowerShell .ps1 script, and a .exe app (which was made using the PowerShell script). Use either one per your preferences or needs. When you run it, Touchscreen-Toggle will (1) check your computer for touchscreen "devices" (that's how Windows sees them)... then (2) disable the enabled ones... and then (3) enable the disabled ones. Lastly, Touchscreen-Toggle will politely closes itself afterward. This all happens in just a few seconds.

### Running the PowerShell script
*(You may need to [set unrestricted execution policy first](https://superuser.com/a/106362) before this works - if anyone knows how to solve this aspect of it, that would be greatly appreciated!)*

1. Find the .ps1 file, wherever you keep it on your computer.
2. Right-click it (or touch and hold using a finger or stylus), then choose **Run With PowerShell**.
3. Say Yes when the UAC prompt comes up (you may need to enter your password!).

That's it! Your touchscreen should be disabled or enabled accordingly. Unfortunately, you have to follow those steps single time you want to toggle your touchscreen so it may get kind of grating after a while. You can't just run the script directly or via a pin/shortcut, since Windows doesn't permit running PowerShell scripts without using the right-click menu for security reasons.

For those reasons, I highly recommend just using the EXE app instead.

### Running the EXE app
Run it like any other app. Each time you do, say Yes when the UAC prompt pops up, and Touchscreen-Toggle will toggle your touchscreen once. Pin it to the taskbar or Start menu, create a desktop, whatever suits your workflow.

If you're security-minded like me, and you require your password for UAC prompts... entering that every time you want to toggle touch gets pretty annoying. Just follow these (kind of technical, but very helpful) steps: https://superuser.com/a/1854880

**Neither the script nor the EXE are signed. Do not use either one unless it has the correct MD5 sum, which you can find in each release's Release Notes.**

## "Why not use other solution(s)?"
The one I made is pretty basic, so this is a fair argument. Every other solution out there will either require 2 pins/shortcuts though - one to enable, one to disable - and/or some hacky workarounds involving PowerShell (since Windows intentionally disallows running PowerShell scripts via shortcut).

Additionally, other convenient solutions don't seem to get the job done, weirdly enough. Take [this solution](https://www.reddit.com/r/Surface/comments/n19kj7/psa_disable_touch_screen_without_disabling_pen_is/) for example, that uses 2 specialized shortcuts to Windows's native `pnputil` to disable or enable the touchscreen on demand. I noticed this comment from u/brutay:
>  I tried following your instructions and when I disabling the touch screen **it continued to register touch input**

I don't have a Surface to test with, so it's entirely possible that my Touchscreen-Toggle app *also* has this issue... but my PowerShell-based approach is hugely reliable on my HP OmniBook X test device, and I wouldn't expect it to have a hardware setup that's much different from any Surface.

## Credits

- **Den Delimarsky**, for creating the function I'm using (and adapted) to show native toast notifications in Windows: https://den.dev/blog/powershell-windows-notification
- **Markus Scholtes**, for creating PS2EXE, which was used to create the app version
- "touch" icon adapted from creation by **Adrien Coquet**, via Noun Project Inc. (CC BY 3.0), to create the icon for this repo and app
- "Light Switch" icon adapted from creation by **Firza Alamsyah**, via Noun Project Inc. (CC BY 3.0), to create the icon for this repo and app
