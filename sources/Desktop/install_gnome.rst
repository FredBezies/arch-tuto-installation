Installation de Gnome
=====================

On passe enfin au morceau de choix : l’installation de Gnome. Le paquet telepathy permet d’ajouter le maximum de support pour les comptes utilisateurs en ligne. Gnome Logiciels (alias gnome-software) est désormais installé avec le méta-paquet gnome.

::

  $ pacman -S gnome gnome-extra system-config-printer telepathy shotwell rhythmbox

L’installation de Gnome est maintenant terminée.

.. include:: ../tips.rst
   :start-line: 1
   :end-line: 19

Pour être certain d’avoir le bon clavier au démarrage de GDM ou d’un autre gestionnaire de connexion comme sddm, lightdm ou lxdm, voici une petite commande à lancer (en modifiant le clavier selon les besoins) ::

  $ sudo localectl set-x11-keymap fr

Les valeurs étant à adapter en fonction de la locale et du clavier, bien entendu.

.. note::
    Si vous avez besoin de gérer des périphériques utilisant MTP (tablettes sous android par exemple), il vous faut rajouter les deux paquets gvfs-mtp et mtpfs.

Étant donné que systemd est utilisé, voici la liste des services à activer (avec une explication rapide), **qui sera la même pour chacun des environnements** proposés dans les « addenda » ::

  $ systemctl enable syslog-ng@default → *gestion des fichiers d’enregistrement d’activité*
  $ systemctl enable cronie → *pour les tâches récurrentes*
  $ systemctl enable avahi-daemon → *dépendance de Cups*
  $ systemctl enable avahi-dnsconfd → *autre dépendance de Cups*
  $ systemctl enable org.cups.cupsd → *cups pour les imprimantes*
  $ systemctl enable bluetooth → *uniquement si on a du matériel bluetooth*
  $ systemctl enable ntpd → *pour synchroniser l’heure en réseau.*

.. note::
    dans un premier temps, il ne faut pas activer le gestionnaire de connexion de l’environnement choisi. On fait uniquement un systemctl start suivi du nom du gestionnaire en question.

Comme je présente Gnome dans la section principale, c’est GDM. Sinon, il faut se référer à l’addenda correspondant.

Sinon, il suffit de se référer à l’addenda correspondant à l’environnement de votre choix.

Au démarrage suivant, GDM nous accueille, et nous pouvons nous connecter.

.. image:: ../../pictures/010.png

*Illustration 10: GDM 3.28.2 avec les sessions Wayland et Gnome sur Xorg*

Finalisons l’installation de Gnome.
***********************************

.. note::
    à partir de maintenant, nous sommes connectés en tant qu’utilisateur classique.

Quelques outils à rajouter : xsane (pour le scanner), mais aussi unoconv (pour l’aperçu des fichiers dans Gnome Documents). On pourrait rajouter Adobe Flash, mais pourquoi rajouter cette usine à faille de sécurité ?

::

  $ sudo pacman -S xsane unoconv

Il faut penser à vérifier que le clavier est correctement configuré. Ce qui se fait dans menu système unifié, options de configuration.

.. image:: ../../pictures/011.png

*Illustration 11: Gnome 3.28.2 en vue activités*

On va personnaliser le bureau Gnome en lui ajoutant la date complète et les boutons pour minimiser et maximiser les fenêtres avec Gnome Tweak Tool alias Ajustements.

.. image:: ../../pictures/012.png

*Illustration 12: Gnome Tweak Tool en action.*

Pour finir une capture d’écran du mode « Gnome Shell ».

.. image:: ../../pictures/013.png

*Illustration 13: Gnome Shell 3.28.2 et « LibreOffice-fresh »*

Voila, le guide est maintenant fini. Cependant, je n’ai pas abordé l’installation d’un pare-feu. C’est quelque chose de plus technique.

J’ai surtout voulu faire un **guide rapide**, histoire de montrer qu’en une petite heure on pouvait avoir un environnement installé et assez complet pour le fignoler par la suite.

Bonne découverte !