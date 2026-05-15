#!/usr/bin/env bash
set -eu
    
    #Paths
    SCRIPT_DIR="$(dirname "$(realpath "$0")")"
    CloudRedirectApp="https://github.com/Selectively11/CloudRedirect/releases/download/linux/cloudredirect.flatpak"

    install_CR(){
    cd $SCRIPT_DIR/
    wget -O cloudredirect.flatpak "$CloudRedirectApp"
    echo "Installing Cloud Redirect App"
    flatpak install --user cloudredirect.flatpak --assumeyes --noninteractive
    echo "App Installed Open It To Configure Your Storage Provider"
    }
    install_CR
