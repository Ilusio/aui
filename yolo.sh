: 'pacman -Syu xorg-server xorg-xinit 
git clone https://aur.archlinux.org/package-query.git
cd package-query
yes | makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
yes | makepkg -si
cd ..

rm -rf package-query
rm -rf yaourt

yaourt -Sy --noconfirm bspwm zsh alacritty oh-my-zsh-git polybar sddm qt5 ttf-fira-mono i3lock rofi sxhkd feh mpd compton xorg-xrandr

git clone https://github.com/Eayu/sddm-theme-clairvoyance
sudo mv sddm-theme-clairvoyance /usr/share/sddm/themes/clairvoyance



mkdir -p ~/.config/
cp -r ./.config/ ~/.config/

cp ./.Xresources ~/
cp ./.xinitrc ~/

mkdir -p ~/Pictures
cp -r ./Wallpaper ~/Pictures/


chmod 755 ~/config/bspwm/bspwmrc
chmod 755 ~/config/sxhkd/sxhkdrc
chmod 755 ~/.fehbg
cp -r ./.config/ ~/.config/
yaourt -Sy ttf-fira-mono dina-font ttf-font-awesome-4 mpc gnome-calendar alsa-utils dunstify dunst light ncmpcpp

cp -r ./.scripts ~
chmod 755 ~/.scripts/*
'
git clone https://github.com/BlackLight/mopidy-spotify.git
cd mopidy-spotify
sudo python2 setup.py install