# MidsReborn Flatpak (Unofficial)
An unofficial Flatpak container for the MidsReborn Character Builder:  
[MidsReborn Website](https://midsreborn.com)  
[MidsReborn Github](https://github.com/LoadedCamel/MidsReborn)

It is installed from the .zip archive, so all databases are accessible.

## Requirements
[Flatpak](https://Flatpak.org)

## Installation
1. Download the MidsReborn.flatpak file found in the Releases Section.
2. In your terminal navigate to the directory it downloaded to.
3. Ensure the Flatpak of wine is installed  
   - `flatpak install org.winehq.Wine`
   - Select 1) 'flathub' (system)
   - Select 2) 'app/org.winehq.Wine/x86_64/stable-24.08'
4. Run the command:  
   `flatpak install --user MidsReborn.flatpak`

It will set up an icon for launching Mids available in any standard menu/application launcher. (it may take a few minutes to appear)

## Launching
You can either use the application link that was added to your menu or the terminal command  
    `flatpak run com.midsreborn.MidsReborn`

On the first Launch it will open a window setting up the wine prefix, after a few moments for the dotnet6 installer to download, it will launch the installer.
After the installer completes Mids will launch.

Each Launch thereafter will simply launch mids.

Mids will take approximately 15 seconds to launch, with no splash screen. (Be patient)

## Updating
After downloading the MidsReborn.flatpak from the newest release run:  
   `flatpak install --user MidsReborn.flatpak`  
As in the installation instructions above. It will update the flatpak files to match the newest version, MidsReborn itself and your options will remain as they are.

As of right now the updater contained within Mids is functioning.

If an update occurs that prevents it from functioning, I will update this flatpak to the most recent version.

### Change Notifications
The previous issue with Flatpak 24.08, Wine and NVidia has been resolved, the flatpak has returned to the 24.08 base.

The flatpak now includes the installation for Microsoft .Net8, so it can run MidsReborn 3.7.11.2.

MidsReborn now no longer requires the .Net6 Desktop Runtime, as such it has been removed from the Flatpak.

### Known Bugs
There is no Launch Splash screen, do not ask me to do anything about it, it relies on a component that cannot run through wine.

I have experienced some crashes with no indication of what is causing them. I would recommend saving your builds often to be safe.
