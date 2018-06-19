# Version en ligne de mon tutoriel pour installer Archlinux sans prise de tête :)

Bonjour !

C'est la version en ligne et "dynamique" du tutoriel d'installation que je propose mensuellement sur mon blog <http://frederic.bezies.free.fr/blog>

C'est un complément au document officiel qui m'a été demandé plusieurs fois. J'ai donc pris mon courage à deux mains, utilisé un convertisseur de documents, pas mal de café et j'ai créé un espace pour héberger le document.

En espérant qu'il soit utile.

Bonne lecture !

Ajout au 19 juin 2018, concernant l'ajout des pilotes virtualbox dans une machine virtuelle émulée :

**Attention** : Il y a un bug avec le trio VirtualBox 5.2.12, linux 4.17.x et Xorg 1.20. Bug rapporté ici. https://www.virtualbox.org/ticket/17827

Le correctif ? Créer un fichier /etc/modprobe.d/vbox.conf et y insérer ceci :

```
blacklist vboxguest
```

Il y aura une boite d'alerte dans votre environnement, mais au moins, vous aurez une souris 100% fonctionnelle.
