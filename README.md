# Touchscreen-Toggle
Solution for artists to toggle touchscreens on/off on Windows computers.

---------------

I use a Windows laptop for general computing *and* for drawing. I don't want to use a special glove when drawing just to avoid unwanted touch inputs, I can poke buttons in my art program as needed. Disabling touch in specific art programs in their per-app settings (such as Clip Studio Paint) helps a little, but modern displays have really tiny bezels, so it doesn't help much.

Looking around online, I couldn't find any good solutions for this on Windows computers. I'm sure Linux has a few tricks up its sleeves, but I intentionally don't use that on my laptop since it doesn't suit my needs. So, hopefully this solution will solve it for everyone drawing on a portable Windows computer like I am.

Just download the "source code" files. Use either the EXE or the PowerShell script (which was used to create the EXE) per your preferences or needs. Running either one will check your computer for touchscreen "devices" (that's how Windows sees them)... then it will disable the enabled ones... and then it will enable the disabled ones.

### Using the PowerShell script
1. Find the .ps1 file, wherever you keep it on your computer.
2. Right-click it, then choose **Run With PowerShell**.
3. Say Yes when the UAC prompt comes up (you may need to enter your password!).

That's it! Your touchscreen should be disabled or enabled accordingly. Unfortunately, you have to follow those steps single time you want to toggle your touchscreen (since Windows doesn't permit running PowerShell scripts by double-clicking them, for security reasons) so it may get kind of grating after a while. That's where using it as an app comes in.

### Using the EXE app
You can simply run it like any other app and it will toggle your touchscreen for you. Pin it to the taskbar or Start menu, create a desktop, whatever suits your workflow. However, you'll need to say Yes when the UAC prompt comes up.

If you're security-minded like me, and require your password at UAC prompts... entering that every time you want to toggle touch gets pretty annoying. Just follow these (kind of technical, but very helpful) steps: https://superuser.com/a/1854880

**Neither the script nor the EXE are signed. Do not use either one unless it has the correct MD5 sum, which you can find in each release's Release Notes.**

## Credits

- **Den Delimarsky**, for creating the function I'm using (and adapted) to show native toast notifications in Windows: https://den.dev/blog/powershell-windows-notification
- **Markus Scholtes**, for creating PS2EXE, which was used to create the app version
- "touch" icon adapted from creation by **Adrien Coquet**, via Noun Project Inc. (CC BY 3.0), to create the icon for this repo and app
- "Light Switch" icon adapted from creation by **Firza Alamsyah**, via Noun Project Inc. (CC BY 3.0), to create the icon for this repo and app
