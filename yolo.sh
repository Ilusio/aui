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

yaourt -Sy --noconfirm bspwm zsh alacritty oh-my-zsh-git polybar sddm qt5 ttf-fira-mono i3lock rofi sxhkd feh mpd compton

git clone https://github.com/Eayu/sddm-theme-clairvoyance
sudo mv sddm-theme-clairvoyance /usr/share/sddm/themes/clairvoyance
'


mkdir -p ~/.config/
cp -r ./.config/ ~/.config/

cp ./.Xresources ~/

mkdir -p ~/Pictures
cp -r ./Wallpaper ~/Pictures/