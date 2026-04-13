# h3adcr-b

Headcrab is a rootless Steam client compatibility helper that compares the installed client version, with a known compatible build, installs SLSsteam and control updates.

* Install
- **Requirements**: `wget`, `curl`, `grep`, `awk`, `sed`, `7zip`
```bash
curl -fsSL "https://raw.githubusercontent.com/Deadboy666/h3adcr-b/refs/heads/main/headcrab.sh" | bash
```
## Features
- Installs the latest SLSsteam release.
- Overides Steam client updates to maintain compatibility with SLSsteam updates.
- Rootless operation* *As Long as The Dependacies Are Met.*
## How it works
1. Detects Steam install type: Native, Flatpak, or SteamOS.
2. Reads the installed Steam client manifest and compares it against the compatible version.
3. If compatible, it installs and setup SLSsteam injection.
4. If incompatible, it fetches the required client files and forces a client update using a local override URL.
5. Patches Steam launch scripts to enable LD_AUDIT injection and updates SLSsteam config.

## Supported Client Installs:
  - Native Installs (The Native Package That You Install On Your Distro)
  - Flatpak Installs (Its Native In A Limited Container)
  - Handheld/HTPC Installs (ex. `SteamOS`, `CachyOS`, `Chimera`, `Bazzite`,`Nobara`)

 ## Distro's Supported By h3adcr-b.
   * Fedora Based Distros
      - Mutable (Normally Fedora Spins.)
      - Atomic (Ublue Based Distros)
        
   * Arch Based Distros
     - Arch Based Distros (ex. `Manjaro`, `CachyOS`, `Endevour`, `ArchBTW`)
       
   * Ubuntu/Debian Based Distros.
     
   * **W.I.P Support**
      * Artix?
      * Void Linux*
        *Void Support Being Worked On*
 ```
xbps-install {wget,curl,grep,awk,sed,7zip}
```
- For Troubleshooting h3adcr-b* [View the Wiki](https://github.com/Deadboy666/h3adcr-b/wiki)





