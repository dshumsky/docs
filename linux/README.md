#### Ubuntu

- Enable SSH:  ```apt-get install openssh-server openssh-client```
- Install Mate (https://linuxconfig.org/how-to-install-mate-desktop-on-ubuntu-18-04-bionic-beaver-linux)
- Terminal history: ```sudo vim /etc/inputrc```
- System > Preferences > Hardware > Keyboard Shortcuts: **shutter -s**
- https://extensions.gnome.org/extension/1160/dash-to-panel/
- https://extensions.gnome.org/extension/723/pixel-saver/
- https://extensions.gnome.org/extension/310/alt-tab-workspace/
- dconf-editor (/org/gnome/desktop/wm/keybindings/switch-to-workspace-*)
- Tweaks -> Fonts -> Scaling Factor
- `sudo apt-get install compizconfig-settings-manager`, ccsm > Desktop > Desktop Wall
- `sudo vim /etc/sudoers`, add `username ALL=(ALL) NOPASSWD: ALL`
- `dconf-editor` -> `org->gnome->shell->app-switcher`: `current-workspace-only` to `true`
- ``` 
  gsettings list-schemas | grep org.gnome.desktop.interface
  gsettings list-keys org.gnome.desktop.interface
  gsettings get org.gnome.desktop.interface text-scaling-factor
  gsettings set org.gnome.desktop.interface text-scaling-factor 0.9
  ```
- gsettings set org.mate.marco.general.focus-new-window 'strict'
- https://plugins.jetbrains.com/plugin/9541-hidpi-profiles  

#### HiDPI
https://askubuntu.com/questions/955038/change-the-display-scaling-on-the-fly
gsettings set org.gnome.desktop.interface text-scaling-factor 1.12
gsettings set org.gnome.desktop.interface cursor-size 24
https://ubuntu-mate.community/t/how-to-tweak-your-panel-layouts/884
Mate Tweak, Appearence Fonts 

#### Suspend Fix
- `sudo dd if=/dev/null of=/var/log/syslog` to clear syslog
- `systemctl suspend -i`
- `http://linrunner.de/en/tlp/docs/tlp-linux-advanced-power-management.html`

#### Commands
- Check SSH public-private keys
    - `cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys`
    - `ssh -i $HOME/.ssh/id_rsa localhost`
- Find file and do something: [http://find.unixpin.com/ru/index.html](http://find.unixpin.com/ru/index.html)
- Find and replace
    ```bash
    find . -type f -name "*.xml" -exec sed -i "s/spring-beans-2\.0\.xsd/spring-beans-3\.0\.xsd/g" {} \;
    ```
- Replace
    ```bash
    sed '/#.*/ d; /^$/ d' /etc/my.cnf
    ```
- Find file with content
    ```bash
    find . -name "*.java" -exec grep "save\|update" {} \;  -print
    ```

- Zip files from txt-file
    ```
    zip files.zip -@ < files.txt
    ```
- Find file in archives
    ```
    for f in `ls *.jar`; do echo "$f: "; unzip -l $f | grep 'Table'; done
    ```

#### Audio

##### Audio. Configure `switch-on-connect` 
1. create ~/.config/pulse/default.pa if it doesn't exist and append
```
.include /etc/pulse/default.pa
load-module module-switch-on-connect
```
This is better than editing /etc/pulse/default.pa.
Afterwards you should run ```pulseaudio -k && pulseaudio --start``` to have the changes take effect.

##### Audio. Fix `Dummy Output`
```
pulseaudio --kill
sudo alsa force-reload
pulseaudio --start
```

##### Audio. Fix `Jabra Audio`
Add to `/usr/share/X11/xorg.conf.d/jabra.conf` (with sudo) and then restart  
```
Section "InputClass"
    Identifier "Jabra Audio docking station"
    MatchDevicePath "/dev/input/event*"
    MatchProduct "Netcom"
    MatchVendor "GN_Netcom_A_S"
    Option "Ignore" "true"
EndSection
```
you can disconnect/connect the headset or start without it and then connect it and nothing freezes.
