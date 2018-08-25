Installons la base
************************
.. role:: shell-cmd

Installer une Archlinux, c’est comme construire une maison. On commence par les fondations, et on rajoute les murs et le reste par la suite. L’image ISO utilisée est la archlinux-2018.08.01-x86\_64.iso, mise en ligne début août 2018.

La machine virtuelle est une machine VirtualBox à laquelle j’ai rajouté un disque virtuel de 128 Go. Des points spécifiques concernant l’utilisation dans VirtualBox sont indiqués. Par défaut, le noyau proposé par Archlinux est un noyau « court terme ». Si vous voulez un noyau LTS, je vous expliquerai comment faire.

Dans cette partie, certaines sections seront dédoublées à cause des différences entre l’installation en mode Bios et en mode UEFI.

Commençons par une installation en mode Bios, du point de vue du partitionnement et de l’attribution des partitions. Si vous utilisez une machine réelle ou virtuelle avec l’UEFI, des instructions spécifiques sont détaillées par la suite.

Partitionnement et attribution des partitions en mode Bios
==========================================================

Voici donc l’écran qui nous permet de démarrer. J’expliquerai plus bas comment faire cohabiter des logiciels 32 et 64 bits sur une seule installation.

.. image:: ../pictures/001.png

*Illustration 1: écran de démarrage en mode Bios, version 64 bits*


La première chose à faire, c’est d’avoir le clavier français ::

  $ loadkeys fr

.. warning::
    Voir le tableau plus bas si votre clavier n'est pas français.

Pour le partitionnement, si vous avez peur de faire des bêtises, il est plus prudent de passer par un LiveCD comme gParted disponible à l’adresse suivante : http://gparted.org/

Avec cfdisk, sur l’écran de démarrage suivant, on choisit l’option « dos » pour le « label type » à appliquer.

.. image:: ../pictures/002.png

*Illustration 2: premier démarrage de cfdisk*

Pour le partitionnement en question :

  +-----------+-------------------+-------------------------------------+-----------------------+
  | Référence |  Point de montage |  Taille                             |   Système de fichiers |
  +-----------+-------------------+-------------------------------------+-----------------------+
  | /dev/sda1 | /boot             | 512 Mo                              |  ext4                 |
  +-----------+-------------------+-------------------------------------+-----------------------+
  | /dev/sda2 |                   | | Taille de la mémoire vive ou plus |                       |
  |           |                   | | à partir de 8 Go de mémoire vive, |  swap                 |
  |           |                   | | 1 Go est conseillé                |                       |
  +-----------+-------------------+-------------------------------------+-----------------------+
  | /dev/sda3 | /                 | 20 Go minimum                       |  ext4                 |
  +-----------+-------------------+-------------------------------------+-----------------------+
  | /dev/sda4 | /home             | Le reste du disque                  |  ext4                 |
  +-----------+-------------------+-------------------------------------+-----------------------+

Il ne faut pas oublier de définir la partition attribuée à :guilabel:`/boot` comme démarrable (bootable). Ce qui donne l’écran suivant dans cfdisk.

.. image:: ../pictures/003.png

*Illustration 3: cfdisk en action*

Pour le formatage des partitions, il suffit d’entrer les commandes suivantes ::

  $ mkfs.ext4 /dev/sda1
  $ mkfs.ext4 /dev/sda3
  $ mkfs.ext4 /dev/sda4

Sans oublier la partition de swap ::

  $ mkswap /dev/sda2
  $ swapon /dev/sda2

On va ensuite créer les points de montage et y associer les partitions qui correspondent::

  $ mount /dev/sda3 /mnt
  $ mkdir /mnt/{boot,home}
  $ mount /dev/sda1 /mnt/boot
  $ mount /dev/sda4 /mnt/home

On peut passer ensuite à l’installation de la base.

Partitionnement et attribution des partitions en mode UEFI
==========================================================

Voici donc l’écran qui nous permet de démarrer en mode UEFI, supporté uniquement pour la version 64 bits.

.. image:: ../pictures/004.png

*Illustration 4: démarrage en mode UEFI*

Comme pour la section concernant le partitionnement en mode Bios, si vous craignez de faire des bêtises, vous pouvez utiliser gParted en mode liveCD : http://gparted.org/

Il faut se souvenir qu’il faut **obligatoirement** une table de partition GPT en cas d’installation en mode UEFI. Si vous n’êtes pas passé par gParted, il faut utiliser l’outil cgdisk.

  +-----------+-------------------+-------------------------------------+---------------------+
  | Référence |  Point de montage |  Taille                             | Système de fichiers |
  +-----------+-------------------+-------------------------------------+---------------------+
  | /dev/sda1 | /                 | 20 Go minimum                       |  ext4               |
  +-----------+-------------------+-------------------------------------+---------------------+
  | /dev/sda2 | /boot/efi         | 128 Mo                              |  fat32              |
  +-----------+-------------------+-------------------------------------+---------------------+
  | /dev/sda3 |                   | | Taille de la mémoire vive ou plus |                     |
  |           |                   | | à partir de 8 Go de mémoire vive, |                     |
  |           |                   | | 1 Go est conseillé                |  swap               |
  +-----------+-------------------+-------------------------------------+---------------------+
  | /dev/sda4 | /home             | Le reste du disque                  |  ext4               |
  +-----------+-------------------+-------------------------------------+---------------------+

.. note::
    pour la partition :guilabel:`/boot/efi`, il faut qu’elle soit étiquetée en EF00 à sa création. Pour le swap, c’est la référence 8200.

.. image:: ../pictures/005.png

*Illustration 5: cgdisk en action pour un partitionnement avec un UEFI*

Le partitionnement à appliquer ? C’est le suivant ::

  $ mkfs.ext4 /dev/sda1
  $ mkfs.fat -F32 /dev/sda2
  $ mkfs.ext4 /dev/sda4

Sans oublier la partition de swap ::

  $ mkswap /dev/sda3
  $ swapon /dev/sda3

Et pour les points de montage ::

  $ mount /dev/sda1 /mnt
  $ mkdir /mnt/{boot,home}
  $ mkdir /mnt/boot/efi
  $ mount /dev/sda2 /mnt/boot/efi
  $ mount /dev/sda4 /mnt/home

On peut passer à l’installation de la base.

Installation de la base de notre Archlinux
==========================================

Après avoir procédé au partitionnement et à l’attribution des partitions, on peut attaquer les choses sérieuses, à savoir récupérer la base de notre installation. mais avant toute chose, choisissons le miroir le plus rapide.

.. note::
    si vous utilisez une connexion wifi, je vous conseille de voir cette page du wiki anglophone d'archlinux : https://wiki.archlinux.org/index.php/Netctl

.. note::
    si vous êtes derrière un serveur proxy, il faut rajouter les lignes suivantes avec les valeurs qui vont bien. Merci à Nicolas pour l'info 🙂

::

  $ export http_proxy=http://leproxy:leport/

Avec l’outil nano nous allons modifier le fichier :guilabel:`/etc/pacman.d/mirrorlist` pour ne garder qu’un seul miroir. Le plus proche géographiquement et aussi le plus rapide possible. Pour une personne vivant en France, c’est **de préférence** mir.archlinux.fr et / ou archlinux.polymorf.fr.

.. image:: ../pictures/006.png

*Illustration 6: la liste des miroirs disponibles.*

| J’ai utilisé le raccourci clavier suivant :kbd:`ALT+R`. On entre dans un premier temps :guilabel:`Server`.
| On presse la touche entrée.
| On saisit :guilabel:`\#Server` pour commenter tous les serveurs.

| Avec le raccourci clavier :kbd:`CTRL+W`, il suffit de saisir le nom du serveur qu’on veut utiliser et enlever la « \# » sur sa ligne.
| Un :kbd:`CTRL+X` suivi de la touche :kbd:`y` (pour yes) permet d’enregistrer la modification.
| Puis on valide en appuyant sur la touche :kbd:`A`.

On passe à l’installation de la base. La deuxième ligne rajoute certains outils bien pratiques à avoir dès le départ. On peut ensuite s’attaquer à l’installation proprement dite.

::

  $ pacstrap /mnt base base-devel pacman-contrib
  $ pacstrap /mnt zip unzip p7zip vim mc alsa-utils syslog-ng mtools dosfstools lsb-release ntfs-3g exfat-utils bash-completion

Si on veut utiliser un noyau linux long terme, il faut rajouter à la deuxième ligne pacstrap le paquet :guilabel:`linux-lts`. Pour ntfs-3g, c’est utile si vous êtes amené à utiliser des disques formatés en ntfs. Si ce n’est pas le cas, vous pouvez l’ignorer allègrement.

.. note::
    exfat-utils m’a été conseillé par André Ray pour la prise en charge des cartes SD de grande capacité. Merci pour le retour !

Si vous êtes sur un pc portable, l’ajout de tlp est conseillé pour améliorer l’autonomie de la batterie. Plus d’info sur cette page : https://wiki.archlinux.org/index.php/TLP

Maintenant que les outils de base sont installés, il faut générer le fichier /etc/fstab qui liste les partitions présentes.

::

  $ genfstab -U -p /mnt >> /mnt/etc/fstab

Au tour du chargeur de démarrage. J’utilise Grub2 qui s’occupe de tout et récupère les paquets qui vont bien. Le paquet os-prober est indispensable pour un double démarrage.

1. Pour un ordinateur avec BIOS ::

    $ pacstrap /mnt grub os-prober

2. Pour un ordinateur avec UEFI ::

    $ pacstrap /mnt grub os-prober efibootmgr

On passe aux réglages de l’OS qu’on vient d’installer. Il faut donc y entrer. On utilise la commande suivante ::

  $ arch-chroot /mnt

Avant d’aller plus loin, voici quelques infos pratiques. Cela concerne les pays francophones comme la Belgique, la Suisse, le Luxembourg ou encore le Canada francophone.

Nous allons par la suite créer des fichiers qui demanderont des valeurs précises. Les voici résumées ici :

  +------------+---------------+------------------+
  | Pays       | Locale (LANG) | Clavier (KEYMAP) |
  +------------+---------------+------------------+
  | Belgique   |  fr\_BE.UTF-8 |  be-latin1       |
  +------------+---------------+------------------+
  | Canada     |  fr\_CA.UTF-8 |  cf              |
  +------------+---------------+------------------+
  | France     |  fr\_FR.UTF-8 |  fr-latin9       |
  +------------+---------------+------------------+
  | Luxembourg |  fr\_LU.UTF-8 |  fr-latin9       |
  +------------+---------------+------------------+
  | Suisse     |  fr\_CH.UTF-8 |  fr\_CH          |
  +------------+---------------+------------------+

Pour avoir le bon clavier en mode texte, créez le fichier :guilabel:`/etc/vconsole.conf`. Il suffira de l’adapter si le besoin s’en fait sentir.

::

  KEYMAP=fr-latin9
  FONT=eurlatgr

Pour avoir la localisation française, le fichier :guilabel:`/etc/locale.conf` doit contenir la bonne valeur pour LANG. Pour une personne en France métropolitaine ::

  LANG=fr_FR.UTF-8
  LC_COLLATE=C

.. note::
  La deuxième ligne est nécessaire si on apprécie d’avoir le tri par la « casse » (majuscule puis minuscule) activé. Merci à Igor Milhit pour la remarque !

Il faut vérifier que la ligne fr\_FR.UTF-8 UTF-8 dans le fichier :guilabel:`/etc/locale.gen` n’a pas de \# devant elle. Ainsi que la ligne en\_US.UTF-8 UTF-8. Évidemment, la valeur fr\_FR.UTF-8 doit être modifiée si besoin est. On va maintenant générer les traductions ::

  $ locale-gen

On peut spécifier la locale pour la session courante, à modifier en fonction de votre pays ::

  $ export LANG=fr_FR.UTF-8

Le nom de la machine ? Il est contenu dans le fichier :guilabel:`/etc/hostname`. Il suffit de taper le nom sur la première ligne. Par exemple : *fredo-archlinux-gnome.* À remplacer par le nom de la machine bien entendu.

Le fuseau horaire ? Une seule étape. Prenons le cas d’une installation avec le fuseau horaire de Paris. Tout dépend de votre lieu de résidence. On commence par créer un lien symbolique ::

  $ ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

Ensuite, deux cas se présentent. Soit on a une machine en mono-démarrage sur Archlinux, et on peut demander à ce que l’heure appliquée soit UTC, soit un double démarrage avec MS-Windows. Restons dans ce premier cas ::

  $ hwclock --systohc --utc

**Sinon, on ne touche à rien.** MS-Windows est un goujat dans ce domaine.

Étape suivante ? Générer le fichier de configuration de Grub.

::

  $ mkinitcpio -p linux ou **linux-lts** si vous voulez le noyau lts.
  $ grub-mkconfig -o /boot/grub/grub.cfg

.. note::
    si vous avez une « hurlante » contenant « /run/lvm/lvmetad.socket: connect failed » ou quelque chose d’approchant, ce n’est pas un bug. C’est une alerte sans conséquence. Cf https://wiki.archlinux.org/index.php/GRUB#Boot_freezes

.. note::
    Simon B m'a fait remarqué qu'en cas de double démarrage avec une autre distribution GNU/Linux déjà installée, il n'est pas indispensable d'installer grub sous Archlinux. Il suffit de faire une commande comme update-grub dans la distribution installée en parallèle d'Archlinux.


1. Pour une installation en mode BIOS ::

    $ grub-install --no-floppy --recheck /dev/sda

2. Pour une installation en mode UEFI :

   La première ligne permet de vérifier un point de montage et de l’activer au besoin. La deuxième installe Grub. Merci à Kevin Dubrulle pour l’ajout.

   ::

   $ mount | grep efivars &> /dev/null || mount -t efivarfs efivarfs /sys/firmware/efi/efivars
   $ grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck


De plus, pour éviter tout problème de démarrage par la suite, spécialement dans VirtualBox, il est conseillé de rajouter les commandes suivantes ::

  $ mkdir /boot/efi/EFI/boot
  $ cp /boot/efi/EFI/arch_grub/grubx64.efi /boot/efi/EFI/boot/bootx64.efi

.. image:: ../pictures/007.png

*Illustration 7 : Génération du noyau linux 4.17.11 début août 2018*

Bien entendu, aucune erreur ne doit apparaître. On donne un mot de passe au compte root ::

  $ passwd root

Pour le réseau, installer et activer NetworkManager est une bonne idée. Vous pouvez remplacer NetworkManager par le duo wicd et wicd-gtk **en cas de problème.** Pour wicd ::

  $ pacman -Syy wicd wicd-gtk
  $ systemctl enable wicd

Et pour Networkmanager ::

  $ pacman -Syy networkmanager
  $ systemctl enable NetworkManager

.. note::
    si vous n’utilisez pas NetworkManager, je vous renvoie à cette page du wiki anglophone d'Archlinux, qui vous aidera dans cette tâche : https://wiki.archlinux.org/index.php/Netctl

.. note::
    netctl et networkmanager rentrent en conflit et **ne doivent pas** être utilisé en même temps. D’ailleurs, netctl et wicd entrent aussi en conflit. Une règle simple : un seul gestionnaire de connexion réseau à la fois !

.. note::
    si vous voulez utiliser des réseaux wifi directement avec NetworkManager et son applet, le paquet gnome-keyring est indispensable. Merci à Vincent Manillier pour l’info.

Si vous voulez utiliser un outil comme Skype (qui est uniquement en 32 bits) et que vous installez un système 64 bits, il faut décommenter (enlever les \#) des lignes suivantes dans :guilabel:`/etc/pacman.conf`::

  #[multilib]
  #Include = /etc/pacman.d/mirrorlist

On peut maintenant quitter tout, démonter proprement les partitions et redémarrer.

C’est un peu plus délicat qu’auparavant. Au moins, on voit les étapes à suivre.

::

  $ exit
  $ umount -R /mnt
  $ reboot

Voilà, on peut redémarrer. **Il faut éjecter le support d’installation pour éviter des problèmes au démarrage suivant.** On va passer à la suite, largement moins ennuyeuse !