Installer Mate-Desktop
======================

.. note::
    commandes à entrer en tant qu’utilisateur classique. Vous pouvez utiliser un enrobeur de pacman comme yaourt, trizen ou yay par exemple.

.. note::
    Si vous avez besoin de gérer des périphériques utilisant MTP (tablettes sous android par exemple), il vous faut rajouter les deux paquets gvfs-mtp et mtpfs.

Si vous voulez la totalité des greffons gvfs (merci à SuperMarioS pour la ligne de commande) ::

  $ sudo pacman -S gvfs-{afc,goa,google,gphoto2,mtp,nfs,smb}

L’installation ressemble à celle de Xfce, donc pour les explications des paquets, cf l’addenda consacré à Xfce. Idem pour l’utilisation de NetworkManager si vous le voulez. Il ne faut pas oublier de rajouter un outil de gravure, comme Brasero si nécessaire. Pour le navigateur, Mozilla Firefox ou Chromium. C’est selon les goûts !

::

    $ sudo pacman -S mate mate-extra lightdm-gtk-greeter gnome-icon-theme vlc quodlibet python2-pyinotify accountsservice claws-mail ffmpegthumbnailer pulseaudio pulseaudio-alsa pulseaudio-bluetooth blueman libcanberra-{pulse,gstreamer} system-config-printer → (pour installer le support des imprimantes)

Si vous voulez personnaliser votre lightdm ::

  $ sudo pacman -S lightdm-gtk-greeter-settings

Pour avoir le bon agencement clavier dès la saisie du premier caractère du mot de passe, il faut entrer la commande suivante avant de lancer pour la première fois lightdm ::

  $ sudo localectl set-x11-keymap fr

Pour lancer Mate Desktop, il faut entrer dans un premier temps ::

  $ sudo systemctl start accounts-daemon
  $ sudo systemctl start lightdm

Si tout se passe bien, on peut utiliser ::

  $ sudo systemctl enable accounts-daemon
  $ sudo systemctl enable lightdm

.. image:: ../../pictures/016.png

*Illustration 16: Mate Desktop 1.20.3*