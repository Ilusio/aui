:'git clone https://aur.archlinux.org/package-query.git
cd package-query
yes | makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
yes | makepkg -si
cd ..

rm -rf package-query
rm -rf yaourt

yaourt -Sy --noconfirm xorg-server xorg-xinit bspwm zsh alacritty oh-my-zsh-git polybar sddm qt5 ttf-fira-mono i3lock rofi sxhkd feh mpd compton xorg-xrandr dina-font ttf-font-awesome mpc gnome-calendar alsa-utils dunstify dunst light ncmpcpp lxappearance materia-gtk-theme paper-icon-theme okular wps-office udisks2 udiskie ntfs-3g vifm intellij-idea-community-edition

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

git clone https://github.com/Eayu/sddm-theme-clairvoyance
mkdir -p /usr/share/sddm/themes/'
sudo mv sddm-theme-clairvoyance /usr/share/sddm/themes/clairvoyance
sudo cp ./sddm.conf /etc/
sudo cp ./Background.jpg /usr/share/sddm/themes/clairvoyance/Assets


mkdir -p ~/.config/
cp -r ./.config/ ~
cp -r ./.scripts ~
cp ./.Xresources ~
cp ./.xinitrc ~

mkdir -p ~/Pictures
cp -r ./Wallpaper ~/Pictures/


chmod 755 ~/config/bspwm/bspwmrc
chmod 755 ~/config/sxhkd/sxhkdrc
chmod 755 ~/.fehbg

chmod 755 ~/.scripts/*

git clone https://github.com/BlackLight/mopidy-spotify.git
cd mopidy-spotify
sudo python2 setup.py install
cd ..

cp .zshrc .zsh_plugins.txt ~

localectl set-x11-keymap fr

systemctl enable sddm.service