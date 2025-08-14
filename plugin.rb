# name: discourse-no-indented-code
# about: Désactive la création de blocs de code par indentation (4 espaces/tabulation) en Markdown.
# version: 0.1
# authors: CAD Generation Team
# url: https://github.com/cadgeneration/discourse-no-indented-code

# Attendre que Discourse soit complètement initialisé avant de modifier le moteur Markdown
after_initialize do
  # Utiliser le système d'événements de Discourse pour intercepter et modifier
  # la configuration du moteur Markdown au moment approprié
  
  # Hook sur l'événement de création du contexte Markdown
  # Cet événement se déclenche à chaque fois qu'un nouveau contexte Markdown est créé
  DiscourseEvent.on(:markdown_context) do |context|
    # Vérifier que nous avons accès à l'instance markdown-it
    if context[:markdown_it]
      # Désactiver la règle 'code' qui gère les blocs de code par indentation
      # Cette règle convertit automatiquement le texte indenté avec 4 espaces ou une tabulation
      # en blocs de code (<pre><code>)
      context[:markdown_it].block.ruler.disable(['code'])
      
      Rails.logger.info("Plugin discourse-no-indented-code: Règle 'code' désactivée pour ce contexte")
    end
  end
  
  # Approche alternative : modifier directement la configuration du moteur
  # en utilisant le hook de pré-traitement
  on(:reduce_cooked) do |fragment, post|
    # Cette méthode est appelée après le rendu Markdown
    # On peut l'utiliser pour vérifier que notre modification fonctionne
  end
  
  # Log de confirmation que le plugin est activé
  Rails.logger.info("Plugin discourse-no-indented-code: Plugin activé avec succès")
end
