#!/bin/bash

export WINEPREFIX="${HOME}/.local/share/mids-flatpak"
export WINEDLLOVERRIDES="mscoree,mshtml="

GIT_REPO="https://api.github.com/repos/Krogoth2787/mids-flatpak/contents"
POE_INSTALLER_NAME="MRB_Release_3.7.4.8.zip"
POE_SETUP="${WINEPREFIX}/${POE_INSTALLER_NAME}"
POE_DOWNLOAD_URL="https://github.com/LoadedCamel/MidsReborn/releases/download/3.7.4.8/MRB_Release_3.7.4.8.zip"
POE_RUN_CMD="${WINEPREFIX}/drive_c/users/${USER}/AppData/Roaming/LoadedCamel/MidsReborn/MidsReborn.exe"
DOTNET_INSTALLER_NAME="windowsdesktop-runtime-6.0.35-win-x64.exe"
DOTNET_SETUP="${WINEPREFIX}/${DOTNET_INSTALLER_NAME}"
DOTNET_DOWNLOAD_URL="https://download.visualstudio.microsoft.com/download/pr/0bfb4b48-9221-491f-8157-eed2307f13e6/3d7890b36ae32759d141633afd43787e/windowsdesktop-runtime-6.0.35-win-x64.exe"


WINE="/app/bin/wine"

XORG_LOG="/var/log/Xorg.0.log"

VERSION_NUM="0.2"
VERSION_FILE="${WINEPREFIX}/info.mids.flatpak"

declare -ra WINE_PACKAGES=(directx9 corefonts tahoma)
declare -ra WINE_SETTINGS=('csmt=on' 'shader_backend=arb' 'win11')

echo "###############################################"
echo "## MidReborn 3.7.4.8 Flatpak v${VERSION_NUM}            ##"
echo "##             Packed by: Krogoth            ##"
echo "###############################################"
echo

set_wine_settings(){
    local my_documents="${WINEPREFIX}/drive_c/users/${USER}/My Documents"

    echo "Installing wine requirements."
    winetricks --unattended "${WINE_PACKAGES[0]}"
    rm -rf
    echo "Setting wine settings."
    winetricks --unattended "${WINE_SETTINGS[0]}"
    wait -n

    echo
}

# Run only if POE isn't installed
first_run(){
    # Install Compat.i386 if not found
    flatpak-spawn --host flatpak list|grep org.freedesktop.Platform.Compat.i386|grep 23.08 || \
    flatpak-spawn --host flatpak install -y org.freedesktop.Platform.Compat.i386/x86_64/23.08

    #set wine settings

    echo "${VERSION_NUM}" > "${VERSION_FILE}"

    #download microsoft dotnet
    if [ ! -f "${DOTNET_SETUP}" ]; then
        echo "Downloading Microsoft Dotnet6 Desktop Runtime"
        curl -o "${DOTNET_SETUP}" -O -J -L "${DOTNET_DOWNLOAD_URL}"
    fi

    #download MidsReborn
    if [ ! -f "${POE_SETUP}" ]; then
        echo "Downloading MidsReborn"
        curl -o "${POE_SETUP}" -O -J -L "${POE_DOWNLOAD_URL}"
    fi

    echo "Installing Microsoft Dotnet6 Runtime..."
    "${WINE}" "${DOTNET_SETUP}"
    wait -n

    echo "Installing MidsReborn"
    mkdir -p "${WINEPREFIX}/drive_c/users/${USER}/AppData/Roaming/LoadedCamel/MidsReborn"
    unzip -q "${POE_SETUP}" -d "${WINEPREFIX}/drive_c/users/${USER}/AppData/Roaming/LoadedCamel/MidsReborn"
    #curl -o "${HOME}/.local/share/applications/com.midsreborn.MidsReborn.desktop" -H 'Accept: application/vnd.github.v3.raw' -O -L "${GIT_REPO}/com.midsreborn.MidsReborn.desktop"
    #curl -o "${HOME}/.local/share/icons/hicolor/256x256/com.midsreborn.MidsReborn.svg" -H 'Accept: applications/vnd.github.v3.raw' -O -L "${GIT_REPO}/com.midsreborn.MidsReborn.svg"
    #curl -o "${HOME}/.local/share/metainfo/com.midsreborn.MidsReborn.metainfo" -H 'Accept: applications/vnd.github.v3.raw' -O -L "${GIT_REPO}/com.midsreborn.MidsReborn.metainfo"
}

is_updated(){
    if [ -f "${VERSION_FILE}" ]; then
        last_version="$(cat ${VERSION_FILE})"
    else
        last_version="0"
    fi

    echo "${VERSION_NUM}" > "${VERSION_FILE}"

    if [[ "${VERSION_NUM}" == "${last_version}" ]]; then
        return 0
    else
        return 1
    fi
}

#Main function
startup(){
    if ! grep 'Software\\\\LoadedCamel\\\\MidsReborn' "${WINEPREFIX}/user.reg">/dev/null; then
        echo "MidsReborn not installed."
        first_run
    else
        if ! is_updated; then
            echo "Not up to date, re-run wine settings"
            #set_wine_settings
        fi
    fi

    echo ; echo "Starting MidsReborn..."
    "${WINE}" "${POE_RUN_CMD}"
}

startup
