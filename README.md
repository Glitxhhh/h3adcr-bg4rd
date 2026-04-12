# h3adcr-b

Headcrab is a rootless Steam client compatibility helper that compares the installed client version, with a known compatible build, installs SLSsteam and control updates.

## How it works

1. Detects Steam install type: Native, Flatpak, or SteamOS.
2. Reads the installed Steam client manifest and compares it against the compatible version.
3. If compatible, it installs and setup SLSsteam injection.
4. If incompatible, it fetches the required client files and forces a client update using a local override URL.
5. Patches Steam launch scripts to enable LD_AUDIT injection and updates SLSsteam config.

## Features

- Installs the latest SLSsteam release.
- Overides Steam client updates to maintain compatibility with SLSsteam updates.
- Works with Native, Flatpak, and SteamOS,Bazzite installations.
- Rootless operation* *As Long as The Dependacies Are Met.*
 ## Supported Client Installs.
  
  - Native Installs (The Native Package That You Install On Your Distro)
  - Flatpak Installs (Its Native In A Limited Container)
    
 **Distro's Supported By h3adcr-b.**
   * Fedora Based Distros
     
      - Nobara
      - Fedora
   * Arch/SteamOS Like Distros
     
     - Bazzite
     - CachyOS
     - Steamos
     - Chimera
     - Arch Based Distros (ex. Manjaro, Endevour, Artix?) 
   * Ubuntu/Debian Based Distros.
     
   * **W.I.P Support**
     
      * Void Linux
      * Artix?
        


## Requirements

- Steam installed (Native or Flatpak).
- `wget`, `curl`, `grep`, `awk`, `sed`, `7z` available in PATH.

## Usage

Close Steam, then run:

```bash
curl -fsSL "https://raw.githubusercontent.com/Deadboy666/h3adcr-b/refs/heads/main/headcrab.sh" | bash
```
## Troubleshooting
[View the Wiki](https://github.com/Deadboy666/h3adcr-b/wiki)

## WIP Support
**Void Linux** 
Install Theese Dependacies Before Running Headcrab
```
xbps-install {wget,curl,grep,awk,sed,7zip}
```
## Types Of Installs Headcrab Will Not Support
**Snap Steam Installs** "Install The [Native Binary](https://cdn.akamai.steamstatic.com/client/installer/steam.deb) Or Use The [Flatpak](https://flathub.org/en/apps/com.valvesoftware.Steam)"

**Any Thing That SLS DOES NOT SUPPORT**
