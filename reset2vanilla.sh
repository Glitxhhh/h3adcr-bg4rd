#!/usr/bin/env bash
set -eu

SteamInstallDir=$HOME/.steam/steam
FlatpakSteamInstallDir=$HOME/.var/app/com.valvesoftware.Steam/.steam/steam
FlatpakSLSsteamInstallDir=$HOME/.var/app/com.valvesoftware.Steam/.local/share/SLSsteam
FlatpakSLSsteamConfigDir=$HOME/.var/app/com.valvesoftware.Steam/.config/SLSsteam
SLSsteamInstallDir=$HOME/.local/share/SLSsteam
SLSsteamConfigDir=$HOME/.config/SLSsteam
Headcrab_Downgrader_Path=$HOME/.headcrab


  wheresteam(){
        if [ -d "$FlatpakSteamInstallDir" ]; then
                flatpak run com.valvesoftware.Steam "$@"
        else
                steam "$@"
            fi
                echo "" &> /dev/null
            }
            
  resetlaunch(){
        rm -rf "$Headcrab_Downgrader_Path"
        if [ -d "$FlatpakSteamInstallDir" ]; then
               cd $FlatpakSteamInstallDir/
        else
                cd $SteamInstallDir/
            fi
                rm steam.cfg
                rm steam.sh
            }

   PurgeSLSsteam(){
        if [ -d "$FlatpakSLSsteamConfigDir" ]; then
               #rm -rf "$FlatpakSLSsteamConfigDir"
               rm -rf "$FlatpakSLSsteamInstallDir"
        else
              #rm -rf "$SLSsteamConfigDir"
              rm -rf "$SLSsteamInstallDir"
            fi
            }
            
  PurgeHeadcrab(){
    echo "Bashing The Headcrab With A Cr0wbar.."
    resetlaunch
    PurgeSLSsteam
    echo "Headcrab Despawned Out Of The Enviroment Reloading Save.."
    wheresteam
    }

echo "Headcrab Uninstaller"
PurgeHeadcrab




