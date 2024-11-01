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
3. Run the command
   `Flatpak install --user MidsReborn.flatpak`

It will set up an icon for launching Mids available in any standard menu/application launcher. (it may take a few minutes to appear)

## Launching
You can either use the application link that was added to your menu or the terminal command
    `Flatpak run com.midsreborn.MidsReborn`

On the first Launch it will open a window setting up the wine prefix, after it closes you will need to run the application again.

On the second Launch after a few moments for the dotnet6 installer to download, it will launch the installer.
After the installer completes Mids will launch.

Each Launch thereafter will simply launch mids.

Mids will take approximately 15 seconds to launch, with no splash screen. (Be patient)

## Updating
As of right now the updater contained within Mids is functioning.

If an update occurs that prevents it from functioning, I will update this flatpak to the most recent version.

### Known Bugs
There is no Launch Splash screen, do not ask me to do anything about it, it relies on a component that cannot run through wine.

There are some missing graphics on windows like View Totals, when opening they will throw an error. You can click Continue and the App will continue to function.

I have experienced some crashes with no indication of what is causing them. I would recommend saving your builds often to be safe.
