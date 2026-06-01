
        fi

        if [ -e "$local_target" ]; then
            echo "Found: $local_target"
            echo "Renaming $local_target -> ${local_target}.bak"
            mv -- "$local_target" "${local_target}.bak"
            acted=1
        fi

        if [ "$acted" -eq 0 ]; then
            echo "Not present: $flatpak_target"
            echo "Not present: $local_target"
        fi
    }
	
    TrashiteWatMani(){
		wheresteampackage
		if [ -f "steam_client_steamdeck_stable_ubuntu12.installed"]; then
			echo "Headcrab Downloading Bazzite-Deck Client Manifest"
			wget "$DeckClientManifest" &> /dev/null
		else
			echo "Headcrab Downloading Bazzite-Desktop Client Manifest"
			wget "$LinuxClientManifest" &> /dev/null
		fi
			echo "" &> /dev/null
		}

	CachyWatMani(){
		wheresteampackage
		if [ -f "steam_client_steamdeck_stable_ubuntu12.installed" ]; then
			echo "Headcrab Downloading CachyOS-Handheld Client Manifest"
			wget "$DeckClientManifest" &> /dev/null
		else
			echo "Headcrab Downloading CachyOS-Desktop Client Manifest"
			wget "$LinuxClientManifest" &> /dev/null
		fi
			echo "" &> /dev/null
		}
		
    DownloadClientManifest(){
	    if steamoscheck; then
	        echo "Headcrab Downloading Steamos Client Manifest.."
	        wget "$DeckClientManifest" &> /dev/null
		elif bazzitecheck; then
			TrashiteWatMani
		elif cachyoscheck; then
			CachyWatMani
	    else
	        echo "Headcrab Downloading Linux Client Manifest.."
	        wget "$LinuxClientManifest" &> /dev/null
	    fi
	        echo "Client Manifest Downloaded"
    }
    
    download_dgsc(){
        mkdir -p $Headcrab_Downgrader_Path
        cd $Headcrab_Downgrader_Path/
        if [ -f "$Headcrab_Downgrader_Path/dgsc" ]; then
            echo "Headcrab_dgsc Downloaded Already."
        else
            echo "Downloading Headcrab_dgsc.."
            wget "$dgsc" &> /dev/null
            chmod +x dgsc
        fi
          echo "" &> /dev/null
        }
        
        download_dlm(){
        mkdir -p $Headcrab_Downgrader_Path
        cd $Headcrab_Downgrader_Path/
        if [ -f "$Headcrab_Downgrader_Path/dlm" ]; then
            echo "Headcrab_dlm Downloaded Already."
        else
            echo "Downloading Headcrab_dlm.."
            wget "$dlm" &> /dev/null
            chmod +x dlm
        fi
          echo "" &> /dev/null
        }
        
        dlm(){
        download_dlm
        echo "Running Fetching Client Update Headcrab_dlm.."
        wheresteampackage
        $Headcrab_Downgrader_Path/dlm --input-file sources.txt --max-concurrent 16
        echo "Headcrab_dlm Fetched Client Update"
        }
        
    dgsc(){
        download_dgsc
        echo "Running Headcrab_dgsc.."
        wheresteampackage
        $Headcrab_Downgrader_Path/dgsc --port 1666 --silent & sleep 1s "$@"
        }
        
    prepdowngrade(){
        wheresteamcfg
        rm package/*
        wheresteampackage
        wget "$Sources" &> /dev/null
        DownloadClientManifest
        dlm
        }
        
    clientinstall(){
        echo "the headcrab latches on the steam process.."
		createsteamcfg
        if steamoscheck; then
            echo "Steamos Detected"
            echo "Headcrab Bootstrapping SLSsteam.."
           export_sls wheresteam -exitsteam
		elif bazzitecheck; then
			echo "Bazzite Detected"
            echo "Headcrab Bootstrapping SLSsteam.."
           export_sls wheresteam -exitsteam
		elif cachyoscheck; then
			echo "CachyOS Detected"
            echo "Headcrab Bootstrapping SLSsteam.."
           export_sls wheresteam -exitsteam
        elif flatpakcheck; then
            echo "Headcrab Bootstrapping SLSsteam.."  
			export_sls wheresteam -clearbeta steam://exit
		elif voidcheck; then
			echo "Void Linux"
			echo "Headcrab Bootstrapping SLSsteam.."  
			export_sls wheresteam -clearbeta steam://exit
		else
			export_sls wheresteam -clearbeta -exitsteam &> /dev/null
        fi
            echo "" &> /dev/null
            }
        
    clientdowngrade(){
        prepdowngrade
        overideupdate
        }
        
    nuketheclient(){
                killall steam | true
            }
        
    wheresteam(){
        if [ -d "$FlatpakSteamInstallDir" ]; then
                flatpak run com.valvesoftware.Steam "$@" &> /dev/null
        else
                steam "$@" &> /dev/null
            fi
                echo "" &> /dev/null
            }
            
    wheresteamdir(){
        if [ -d "$FlatpakSteamInstallDir" ]; then
                mkdir -p $FlatpakSLSsteamInstallDir
				mkdir -p $FlatpakCloudRedirectDir
                cp -f $InstallDir/library-inject.so $FlatpakSLSsteamInstallDir/
                cp -f $InstallDir/SLSsteam.so $FlatpakSLSsteamInstallDir/
        else
                 mkdir -p $CloudRedirectDir
				 mkdir -p $SLSsteamInstallDir
                 mkdir -p $SLSsteamConfigDir
                 cp -f $InstallDir/library-inject.so $SLSsteamInstallDir/
                 cp -f $InstallDir/SLSsteam.so $SLSsteamInstallDir/
            fi
				echo "" &> /dev/null
            }
            
    wheresteamcfg(){
        if [ -d "$FlatpakSteamInstallDir" ]; then
               cd $FlatpakSteamInstallDir/
        else
                cd $SteamInstallDir/
            fi
                echo "" &> /dev/null
            }
			
	wheresteampackage(){
        if [ -d "$FlatpakSteamInstallDir" ]; then
               cd $FlatpakSteamInstallDir/package
        else
                cd $SteamInstallDir/package
            fi
                echo "" &> /dev/null
            }

    whereSLSsteamconfig(){
        if [ -d "$FlatpakSLSsteamConfigDir" ]; then
               mkdir -p $FlatpakSLSsteamConfigDir
               cd $FlatpakSLSsteamConfigDir/
        else
                mkdir -p $SLSsteamConfigDir
                cd $SLSsteamConfigDir/
            fi
                echo "" &> /dev/null
            }
            
    overideupdate(){
        echo "the headcrab latches on the steam process.."
		killall dgsc | true
        if steamoscheck; then
            echo "Steamos Detected"
            createsteamcfg
            dgsc
            echo "Headcrab Connecting to The Updater.."
           export_sls wheresteam -textmode -forcesteamupdate -forcepackagedownload -overridepackageurl "$Headcrab_Downgrade_URL" -exitsteam &> /dev/null
		elif bazzitecheck; then
			echo "Bazzite Detected"
            createsteamcfg
            dgsc
            echo "Headcrab Connecting to The Updater.."
           export_sls wheresteam -textmode -forcesteamupdate -forcepackagedownload -overridepackageurl "$Headcrab_Downgrade_URL" -exitsteam &> /dev/null
        else
            createsteamcfg
            dgsc
            echo "Headcrab Connecting to The Updater.."
            export_sls wheresteam -clearbeta -textmode -forcesteamupdate -forcepackagedownload -overridepackageurl "$Headcrab_Downgrade_URL" -exitsteam &> /dev/null
        fi
            killall dgsc
            echo "Compatible Update Applied Via Headcrab_dgsc"
            }
            
    checkforsteamcfg(){
    echo "the headcrab approaches.."
    wheresteamcfg
    if [ -f "steam.cfg" ]; then
        rm steam.cfg
    else
        echo "No Pre Exisiting Steam.cfg"
    fi
        nuketheclient
        CheckHeadcrabCompatibility
        conditioncheck
        }

    downloadSLSsteam(){
        echo "Downloading Latest SLSsteam.."
        cd $SCRIPT_DIR/
        mkdir -p $SCRIPT_DIR/SLSsteam_Download
        cd SLSsteam_Download
        local TAG
        TAG=$(curl -sSL --connect-timeout 15 --max-time 30 \
            -o /dev/null -w "%{url_effective}" \
            "https://github.com/AceSLS/SLSsteam/releases/latest" 2>/dev/null)
        TAG="${TAG##*/}"
        wget -O SLSsteam-Any.7z \
            "https://github.com/AceSLS/SLSsteam/releases/download/$TAG/SLSsteam-Any.7z" &> /dev/null
    }
    
    export_sls(){
        if [ -d "$FlatpakSteamInstallDir" ]; then
                copySLSsteam
                LD_AUDIT=$HOME/.var/app/com.valvesoftware.Steam/.local/share/SLSsteam/library-inject.so:$HOME/.var/app/com.valvesoftware.Steam/.local/share/SLSsteam/SLSsteam.so "$@"
        else
                copySLSsteam
                LD_AUDIT=$HOME/.local/share/SLSsteam/library-inject.so:$HOME/.local/share/SLSsteam/SLSsteam.so "$@"
        fi
                echo &> /dev/null
                }

    extractSLSsteam(){
        downloadSLSsteam
         7z x $SCRIPT_DIR/SLSsteam_Download/SLSsteam-Any.7z -aoa > /dev/null
         rm -rf tools
         rm -rf res
         rm setup.sh
         rm -rf docs
         rm SLSsteam-Any.7z
		 echo "SLSsteam Downloaded: Latest"
		 cd $InstallDir/
         }

    copySLSsteam(){
        extractSLSsteam
        wheresteamdir
        rm -rf $InstallDir
        }

    InstallSLSsteam(){
        echo "Installing SLSsteam..."
        if [ -d "$SLSsteamInstallDir" ]; then
          copySLSsteam
        else
            copySLSsteam
        fi
            echo &> /dev/null
        }

    editconfig(){
        whereSLSsteamconfig
            if [ -f .headcrabd ]; then
                echo "Headcrab Config Found Skipping Changes"
            else
                sed -i "s/^PlayNotOwnedGames:.*/PlayNotOwnedGames: yes/" config.yaml
                sed -i "s/^SafeMode:.*/SafeMode: yes/" config.yaml
				sed -i "s/^NotifyInit:.*/NotifyInit: yes/" config.yaml
				sed -i "s/^Notifications:.*/Notifications: yes/" config.yaml
				echo "config patched" > .headcrabd
                fi
            }

    createsteamcfg(){
    wheresteamcfg
    if [ -f "steam.cfg" ]; then
        echo "steam.cfg Found Skipping Creation Process.."
    else
        cat << 'EOF' > steam.cfg
BootStrapperInhibitAll=enable
BootStrapperForceSelfUpdate=disable
EOF
    fi
        echo "" &> /dev/null
    }

    patchsteam(){
        if [ -d "$FlatpakSteamInstallDir" ]; then
                patchflatpaksteam
        else
                patchlocalsteam
        fi
        }

        
    patchflatpaksteam(){
        cd $FlatpakSteamInstallDir/
        if [ -f "steam.sh" ]; then
            rm steam.sh
			wget -O client.sh "$Headcrab_Client" &> /dev/null
        	wget -O steam.sh "$Headcrab_Flatpak" &> /dev/null
			chmod 555 steam.sh
			chmod +x client.sh
		fi
            echo "SLSSteamInstallType: Flatpak"
        }

    patchlocalsteam(){
        cd $SteamInstallDir/
        if [ -f "steam.sh" ]; then
            rm steam.sh
			wget -O client.sh "$Headcrab_Client" &> /dev/null
        	wget -O steam.sh "$Headcrab_Native" &> /dev/null
			chmod 555 steam.sh
			chmod +x client.sh
		fi
        	echo "SLSSteamInstallType: Local"
        }

        conditioncheck(){
            echo "Checking Conditions..."
            patchsteam
            echo "BlockedClientUpdates: Enabled"
            editconfig
            echo "HeadcrabStatus: Patched"
            }

    main(){
        preinstallchecks
		SetupHeadcrab_Updater
        checkforsteamcfg
        }

    main
