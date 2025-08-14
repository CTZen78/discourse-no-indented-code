# Plugin Discourse : No Indented Code

## Description

Ce plugin Discourse désactive la règle de formatage Markdown qui convertit automatiquement le texte indenté avec 4 espaces ou une tabulation en blocs de code.

**Fonctionnalités :**
- ✅ Désactive la création automatique de blocs de code par indentation
- ✅ Préserve la fonctionnalité des blocs de code avec la syntaxe des apostrophes inversées (```)
- ✅ Compatible avec toutes les versions récentes de Discourse
- ✅ Installation simple et rapide

## Pourquoi ce plugin ?

Par défaut, Markdown (et donc Discourse) convertit automatiquement tout texte précédé de 4 espaces ou d'une tabulation en bloc de code. Cela peut être gênant dans certains contextes, notamment :

- Lors de la rédaction de listes imbriquées
- Pour l'indentation naturelle de texte dans des discussions
- Quand on veut préserver la mise en forme sans créer de blocs de code

Ce plugin résout ce problème en désactivant uniquement cette règle spécifique, tout en conservant toutes les autres fonctionnalités Markdown.

## Installation

### 1. Via l'interface d'administration Discourse

1. Connectez-vous en tant qu'administrateur sur votre instance Discourse
2. Allez dans **Administration > Plugins**
3. Cliquez sur **Install Plugin**
4. Entrez l'URL du repository : `https://github.com/cadgeneration/discourse-no-indented-code`
5. Cliquez sur **Install**
6. Redémarrez votre instance Discourse

### 2. Installation manuelle

1. Connectez-vous à votre serveur Discourse via SSH
2. Naviguez vers le dossier des plugins :
   ```bash
   cd /var/discourse/containers/app/plugins/
   ```
3. Clonez ce repository :
   ```bash
   git clone https://github.com/cadgeneration/discourse-no-indented-code.git
   ```
4. Reconstruisez votre instance Discourse :
   ```bash
   cd /var/discourse
   ./launcher rebuild app
   ```

### 3. Via app.yml (recommandé pour la production)

1. Éditez le fichier `app.yml` de votre instance Discourse :
   ```bash
   nano /var/discourse/containers/app.yml
   ```

2. Ajoutez la ligne suivante dans la section `hooks > after_code` :
   ```yaml
   hooks:
     after_code:
       - exec:
           cd: $home/plugins
           cmd:
             - git clone https://github.com/cadgeneration/discourse-no-indented-code.git
   ```

3. Reconstruisez votre instance :
   ```bash
   ./launcher rebuild app
   ```

## Vérification du fonctionnement

Après l'installation, testez le plugin en créant un nouveau post avec du texte indenté :

**Avant le plugin :**
```
    Ce texte sera converti en bloc de code
```

**Après le plugin :**
```
    Ce texte restera du texte normal indenté
```

Les blocs de code avec apostrophes inversées continuent de fonctionner normalement :
```
```javascript
console.log("Ce code fonctionne toujours !");
```
```

## Configuration

Ce plugin ne nécessite aucune configuration supplémentaire. Il fonctionne automatiquement dès son activation.

## Désinstallation

Pour désinstaller le plugin :

1. Via l'interface admin : **Administration > Plugins > Uninstall**
2. Via SSH : Supprimez le dossier du plugin et reconstruisez l'instance

## Support et Contributions

- **Issues :** Signalez les problèmes sur GitHub
- **Contributions :** Les pull requests sont les bienvenues
- **Documentation :** Consultez la documentation officielle de Discourse pour le développement de plugins

## Licence

Ce plugin est distribué sous licence MIT. Voir le fichier LICENSE pour plus de détails.

## Changelog

### v0.1 (Version initiale)
- Désactivation de la règle de code par indentation
- Préservation des autres fonctionnalités Markdown
- Support multi-versions de Discourse
