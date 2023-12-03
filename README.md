# Note's

Note's est une application de prise de notes qui permet aux utilisateurs de créer, modifier et supprimer leurs notes après s'être connectés. Chaque utilisateur dispose d'une session individuelle pour gérer ses propres notes. L'application intègre un système de login/register et utilise Firebase pour stocker les utilisateurs et leurs notes.

## Fonctionnalités

- Inscription/Connexion :
    Les utilisateurs peuvent créer un compte ou se connecter avec leurs identifiants.
- Gestion des Notes :
    Création de nouvelles notes.
    Modification du contenu des notes existantes.
    Suppression de notes.
- Sessions Utilisateurs :
    Chaque utilisateur a sa propre session pour gérer ses notes.
    Chaque utilisateur peut changer son nom d'utilisateur.
- gestion des erreurs :
    lors d'une erreur l'utilisateur est rediriger vers une page d'erreur.

## Technologies Utilisées

- Flutter
- Firebase


# Rapport

## Problèmes rencontrés

- Probleme de creation de la database sur Firebase
    Nayant jamais utilisé Firebase avant, j'ai eu du mal à créer la database, je ne trouver pas les bon onglet et il me manquer des case a coché comme le mode test pour pouvoir enregistrer mes utilisateur. J'ai finalement réussi à créer la database et à la lier à mon application en suivant les doc.

- Probleme de popup
    Pour ma premiere popup, celle pour ajouter des notes, j'ai rencontré un probleme qui est que lorsque je cliquer sur le bouton pour ajouter une note, la popup s'ouvrait mais elle ne se fermer pas lorsque je cliquer sur le bouton pour ajouter la note. J'ai finalement réussi à régler le probleme en utilisant un return dialog.

- Probleme d'affichage du nom d'utilisateur
    Pour mes test j'avais besoin de savoir quel utilisateur etais connecté, donc j'ai pris la parti du mail. De plus c'est une fonctionnalité interessant pour l'utilisateur. Mais le probleme rencontré est que le nom d'utilisateur ne s'afficher tout simplement pas. J'essayer de l'afficher via la page qui contient tout les utilisateur sur firebase FirebaseAuth jusqu'a ce que je comprennent qu'il n'y avait tout simplement pas de nom d'utilisateur. J'ai donc créé une nouvelle table qui recupere sur FirebaseFirestore qui recupere l'id est met la premiere partie du mail dans un displayName. Et bizzarement ca marcher mieux :D.

- Probleme de gestion d'erreur
    Je voulais faire un systeme qui redirige l'utilisateur sur une seul page avec un text qui change en fonction de l'erreur mais je ne s'avait pas comment recuperer l'erreur et rediriger. Apres beaucoup de test j'ai trouver que je pouvais avoir les code erreur dans le terminal et donc les utiliser pour rediriger l'utilisateur.

- Probleme des images dans les notes
    Un des principaux probleme rencontré est les images, en effet je n'y suis pas arrivé. Le probleme rencontré est du a des permission. Je ne comprend toujours pas pourquoi ca ne marche pas. J'ai donné toute les permission necessaire dans "AndroidManifest.xml" mais ca ne marche toujours pas. J'ai essayé de les attribué directement sur l'application via les parametre mais le bouton le permettant ete grisé. Je ne pouvais donc pas les changer.J'ai essayé sur web, et ca ne marchais pas non plus. J'ai fais recherche, et je n'ai pas trouvé de solution a mon probleme. Apres plusieur a chercher une solution et a mon plus grand regret j'ai arrete le developpement de cette fonctionnalité ＞︿＜.  J'ai tout de meme laisser le code qui est sensé fonctionner et j'aimerais bien avoir un retour si possible. 

Voila pour les principaux probleme que j'ai rencontré.

## Améliorations possibles

- Ajouter une fonctionnalité de partage de note
- Ajouter une fonctionnalité de modification de mot de passe
- Ajouter une fonctionnalité de suppression de compte

## Images 

### Voici un exemple de la gestion des utilisateur
![Voici un exemple de la gestion des utilisateur](./imageReadme/exemple_utilisateur.png)

### Voici un exemple de la gestion des notes
![Voici un exemple de la gestion des notes](./imageReadme/exemple_note.png)

### Voici un exemple de la gestion des userName
![Voici un exemple de la gestion des userName](./imageReadme/exemple_userName.png)

## Les defis

- Le premier defis a été de comprendre comment fonctionne Firebase et comment l'utiliser avec Flutter. J'ai donc du lire la doc et faire des test pour comprendre comment fonctionne Firebase et comment l'utiliser avec Flutter.

- Le deuxieme defis a ete de faire la gestion des utilisateur. Apres quelque test plus ou moins concluant j'ai finalement reussi a faire la gestion des utilisateur avec Firebase.

- Le troisieme defis a ete la gestion des instance et des table. J'ai lu les doc et des forum pour comprendre, quelque test, quelque echec et ca marche.

- Le quatrieme defis a ete la gestion des erreur. Mon idee de faire une page commune a vraiment ete un defis pour trouver comment transmettre les erreur mais mais mon idee a ete concluante. 

## La securité 

La securité que j'ai mit en place est le cryptage des mot de passe pour eviter le vol des session.
Les id des instance de notes sont generer aleatoirement pour eviter de pouvoir les deviner et ecrire dans les notes des autres utilisateurs.
Les utilisateur on des uid et pas des id se qui est plus securisé car aleatoire et plus long.

## Conclusion

Ce projet ete tres interressant car on avait pas encore vu le systeme tres utile de la gestion d'utilisateur et les base de donnée avec flutter. Je suis plutot content de se que j'ai produit :D.