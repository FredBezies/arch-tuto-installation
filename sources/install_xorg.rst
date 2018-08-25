Installons maintenant l’environnement graphique
===============================================
Nous attaquons donc la partie la plus intéressante, l’installation de l’environnement graphique. Il y a des étapes communes à tous les environnements. Un peu plus loin est indiquée la partie concernant **uniquement** Gnome.

Une fois le système démarré, on se connecte **en root**. Étant donné que j’ai installé NetworkManager (ou wicd selon les goûts) à l’étape précédente, le réseau fonctionne directement. J’ajoute ntp (synchronisation de l’heure en réseau) et cronie (pour les tâches d’administration à automatiser).

::

$ pacman -Syy ntp cronie

.. note::
    si on veut avoir les logs en clair en cas de problème, il faut modifier avec nano (ou vim) le fichier :guilabel:`/etc/systemd/journald.conf` en remplaçant la ligne ::

    #ForwardToSyslog=no

    par ::

      ForwardToSyslog=yes

Les outils en place, on lance alsamixer avec la commande du même nom, pour configurer le niveau sonore :

.. image:: ../pictures/008.png
*Illustration 8: alsamixer en action*

Une fois l’ensemble configuré, pour le conserver tel quel, il suffit d’entrer ::

  $ alsactl store

Nous sommes dans le multimédia ? Restons-y.

On va installer l’ensemble des greffons gstreamer qui nous donneront accès aux fichiers multimédias une fois Gnome lancé. Il faudra remplacer **pacman -S** par **sudo pacman -S** quand vous utiliserez votre compte utilisateur « normal » plus tard.

Pour l’exécution de la ligne suivante, il est demandé de choisir un support pour OpenGL. Pour le moment, on choisit MesaGL. La modification correspondant à votre matériel sera faite lors de l’installation de Xorg. Ainsi que la version « libx264 » proposé en premier choix. Merci à Adrien de Linuxtricks pour m’avoir aidé à réduire la longueur de la ligne de commande 🙂

::

  $ pacman -S gst-plugins-{base,good,bad,ugly} gst-libav

gst-libav ? Il prend en charge tout ce qui est x264 et apparenté.

Passons à l’installation de Xorg. Le paquet xf86-input-evdev est obsolète depuis début mars 2017, à cause du passage à xorg-server 1.19.

.. note::
    il n’y a pas d’espace entre le – et le { vers la fin de la commande suivante.

::

    $ pacman -S xorg-{server,xinit,apps} xf86-input-{mouse,keyboard} xdg-user-dirs

Si on utilise un ordinateur portable avec un pavé tactile, il faut rajouter le paquet xf86-input-synaptics ou **de préférence** xf86-input-libinput.

Il faut ensuite choisir le pilote pour le circuit vidéo. Voici les principaux pilotes, sachant que le paquet xf86-video-vesa englobe une énorme partie des circuits graphiques, dont ceux non listés dans le tableau un peu plus loin. En cas de doute : https://wiki.archlinux.org/index.php/Xorg#Driver_installation

Pour Nvidia, c’est un casse-tête au niveau des pilotes propriétaires. Le plus simple est de se référer au wiki d'Archlinux : https://wiki.archlinux.org/index.php/NVIDIA. Et si vous avez la technologie Optimus : https://wiki.archlinux.org/index.php/NVIDIA_Optimus

 +---------------------+--------------------+------------------------------------------------------+
 | Circuits graphiques | Pilotes libres     | Pilotes non libres (si existant)                     |
 +---------------------+--------------------+------------------------------------------------------+
 | AMD                 | xf86-video-ati     |                                                      |
 +---------------------+--------------------+------------------------------------------------------+
 | Intel               | xf86-video-intel   |                                                      |
 +---------------------+--------------------+------------------------------------------------------+
 | Nvidia              | xf86-video-nouveau | | Nvidia (cf le wiki d'archlinux) pour la version à  |
 |                     |                    | | installer en fonction de la carte graphique        |
 +---------------------+--------------------+------------------------------------------------------+

Dans le cas d’une machine virtuelle, j’ai utilisé le paquet **xf86-video-vesa**. On passe ensuite à l’installation des polices. Voici la ligne de commande pour les principales. Le paquet freetype2 apportant quelques améliorations. Merci à Angristan pour la suggestion.

::

  $ pacman -S ttf-{bitstream-vera,liberation,freefont,dejavu} freetype2

.. note::
    pour les polices Microsoft, le paquet ttf-ms-fonts, elles sont sur le dépôt AUR, donc il faut utiliser yaourt pour les récupérer et les installer.

Si vous faites une installation dans VirtualBox, il faut deux paquets. En plus de xf86-video-vesa, il faut le paquet virtualbox-guest-utils. Cependant, il y a deux choix qui arrivent pour ce paquet.

Ce qui donne ::

  $ pacman -S xf86-video-vesa
  $ pacman -S virtualbox-guest-utils

.. image:: ../pictures/009.png
*Illustration 9: Choix du paquet à installer concernant virtualbox-guest-utils*

Le premier nécessite le paquet linux-headers (ou linux-lts-headers), le deuxième propose les modules noyaux déjà précompilés. **On choisit donc la deuxième option.**

.. note::
    si vous avez décidé d’installer le noyau lts, il faut installer les paquets linux-lts-headers et virtualbox-guest-dkms. Il n’y a plus de modules précompilés pour le noyau linux-lts

La prise en charge des modules noyau se fait avec la commande systemctl suivante ::

  $ systemctl enable vboxservice

.. note::
    si vous installez un jour VirtualBox sur une machine réelle je vous renvoie à cette page du wiki francophone : https://wiki.archlinux.fr/VirtualBox

On va rajouter quelques outils, histoire de ne pas voir un environnement vide au premier démarrage.

On commence par tout ce qui est graphique : gimp, cups (gestion de l’imprimante) et hplip (si vous avez une imprimante scanner Hewlett Packard). Le paquet python-pyqt5 est indispensable pour l’interface graphique de HPLIP ::

  $ pacman -S cups gimp gimp-help-fr hplip python-pyqt5

La série des paquets foomatic permet d’avoir le maximum de pilotes pour l’imprimante. Pour être tranquille avec son imprimante ::

  $ pacman -S foomatic-{db,db-ppds,db-gutenprint-ppds,db-nonfree,db-nonfree-ppds} gutenprint

Il y a deux versions supportés par Archlinux pour LibreOffice, en conformité avec ce que propose la Document Foundation. Pour la version **stable** et les utilisateurs **prudents**, on utilise la ligne de commande (hunspell ajoute la vérification orthographique) ::

  $ pacman -S libreoffice-still-fr hunspell-fr

Pour les utilisateurs plus **aventureux**, qui veulent la version récente ::

  $ pacman -S libreoffice-fresh-fr hunspell-fr

On rajoute ensuite Mozilla Firefox en français ::

  $ pacman -S firefox-i18n-fr

Vous préférez Chromium ?

::

  $ pacman -S chromium

On crée un utilisateur avec la commande suivante, qui sera indispensable pour appliquer un des addenda si vous ne voulez pas utiliser Gnome.

::

  $ useradd -m -g wheel -c 'Nom complet de l’utilisateur' -s /bin/bash nom-de-l’utilisateur (sur une seule ligne !)
  $ passwd nom-de-l’utilisateur

Avant de finir, on va configurer sudo en utilisant visudo. En effet, il nous suffit de modifier une ligne pour que l’on puisse accéder en tant qu’utilisateur classique aux droits complets sur la machine de manière temporaire.

Il faut aller, en utilisant la flèche du bas jusqu’à la ligne ::

  #Uncomment to allow members of group wheel to execute any command

Et enlever le \# sur la ligne qui suit. (La séquence de touches « Échap : w et q » permet de converser la modification dans vi.)