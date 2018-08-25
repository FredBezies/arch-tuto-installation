Installer Xfce
==============

.. note::
    commandes à entrer en tant qu’utilisateur classique. Vous pouvez utiliser un enrobeur de pacman comme yaourt, trizen ou yay par exemple.

.. note::
    si vous avez besoin de gérer des périphériques utilisant MTP (tablettes sous android par exemple), il vous faut rajouter les deux paquets gvfs-mtp et mtpfs.

Si vous voulez la totalité des greffons gvfs (merci à SuperMarioS pour la ligne de commande) ::

  $ sudo pacman -S gvfs-{afc,goa,google,gphoto2,mtp,nfs,smb}

.. note::
    courant mars 2017, gstreamer-0.10 a été déprécié, après 4 ans sans la moindre mise à jour par les développeurs, et par conséquent, le greffon audio de Xfce est désormais celui de Pulseaudio, d’où le rajout de pavucontrol dans la liste des paquets.

.. note::
    Midori a été enlevé, le projet semblant être au point mort depuis pas mal de temps.

Pour installer Xfce, il faut entrer ::

  $ sudo pacman -S xfce4 xfce4-goodies gvfs vlc quodlibet python2-pyinotify lightdm-gtk-greeter xarchiver claws-mail galculator evince ffmpegthumbnailer xscreensaver pavucontrol pulseaudio pulseaudio-alsa pulseaudio-bluetooth blueman libcanberra-{pulse,gstreamer} system-config-printer → (pour installer le support des imprimantes)

VLC et Quodlibet ? Pour la vidéo et l’audio. Pour les périphériques amovibles, gvfs est obligatoire. Claws-mail ou Mozilla Thunderbird (avec le paquet thunderbird-i18n-fr) pour le courrier. Lightdm étant pris, car plus rapide à installer. Le paquet python2-pyinotify est nécessaire pour activer le greffon de mise à jour automatique de la musicothèque sous Quodlibet.

Evince ? Pour les fichiers en pdf. On peut aussi remplacer xarchiver par fileroller. Quant à ffmpegthumbnailer, c’est utile si vous désirez avoir un aperçu des vidéos stockées sur votre ordinateur. Enfin, xscreensaver sert au verrouillage de l’écran.

Si vous utilisez NetworkManager, vous pouvez rajouter l’applet pour gérer et surveiller votre réseau avec le paquet « network-manager-applet ». Si vous voulez personnaliser votre lightdm ::

  $ sudo pacman -S lightdm-gtk-greeter-settings

Pour avoir le bon agencement clavier dès la saisie du premier caractère du mot de passe, il faut entrer la commande suivante avant de lancer pour la première fois lightdm ::

  $ sudo localectl set-x11-keymap fr

Pour lancer Xfce, il faut entrer dans un premier temps ::

  $ sudo systemctl start lightdm

Et si tout se passe bien, on peut utiliser ::

  $ sudo systemctl enable lightdm

.. note::
    pour avoir des plus jolies icônes, on peut installer le paquet AUR elementary-xfce-icons ou encore les mint-x-icons. mais après, c’est à vous de voir !

.. image:: ../../pictures/015.png

*Illustration 15: Xfce 4.12.0 en action.*