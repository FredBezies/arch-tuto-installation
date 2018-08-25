Installer Plasma 5.13.x
=======================

.. note::
    commandes à entrer en tant qu’utilisateur classique. Vous pouvez utiliser un enrobeur de pacman comme yaourt, trizen ou yay par exemple.

Dans les précédentes versions, il y avait k3b, mais il a été intégré dans les kde-applications à partir de la version 17.04.

L’installation se déroule ainsi ::

  $ sudo pacman -S plasma kde-applications amarok digikam

Pour avoir le bon agencement clavier dès la saisie du premier caractère du mot de passe, il faut entrer la commande suivante avant de lancer pour la première fois sddm ::

  $ sudo localectl set-x11-keymap fr

Bien entendu, la valeur à utiliser après set-x11-keymap doit être identique à celle saisie plus haut quand on a configuré la base d'Archlinux. Sans oublier le correctif indiqué plus haut dans la section Gnome concernant le clavier français sous Xorg.

::

  $ sudo systemctl start sddm

Si tout se passe bien, on peut utiliser ::

  $ sudo systemctl enable sddm

.. image:: ../../pictures/014.png

*Illustration 14: Plasma 5.13.x (vue de dossiers) avec les KDE Frameworks 5.49.0*