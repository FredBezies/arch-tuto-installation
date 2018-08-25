Installer Deepin-Desktop
========================

.. note::
    commandes à entrer en tant qu’utilisateur classique. Vous pouvez utiliser un enrobeur de pacman comme yaourt, trizen ou yay par exemple.

.. note::
    Si vous avez besoin de gérer des périphériques utilisant MTP (tablettes sous android par exemple), il vous faut rajouter les deux paquets gvfs-mtp et mtpfs. Si vous voulez la totalité des greffons gvfs (merci à SuperMarioS pour la ligne de commande) ::

    $ sudo pacman -S gvfs-{afc,goa,google,gphoto2,mtp,nfs,smb}

L’installation est ultra simple. La ligne de commande est sûrement l’une des plus courtes du document !

::

  $ sudo pacman -S deepin deepin-extra linux-headers system-config-printer → (pour installer le support des imprimantes)

Si vous voulez personnaliser votre lightdm ::

  $ sudo pacman -S lightdm-gtk-greeter-settings

Pour avoir le bon agencement clavier dès la saisie du premier caractère du mot de passe, il faut entrer la commande suivante avant de lancer pour la première fois lightdm ::

  $ sudo localectl set-x11-keymap fr

Pour lancer Deepin Desktop, il faut entrer dans un premier temps ::

  $ sudo systemctl start lightdm

Si tout se passe bien, on peut utiliser ::

  $ sudo systemctl enable lightdm

.. image:: ../../pictures/017.png

*Illustration 17: Deepin Desktop 15.7*