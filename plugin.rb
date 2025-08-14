# name: discourse-no-indented-code
# about: Désactive la création de blocs de code par indentation (4 espaces/tabulation) en Markdown.
# version: 0.1
# authors: CAD Generation Team
# url: https://github.com/cadgeneration/discourse-no-indented-code

# Attendre que Discourse soit complètement initialisé avant de modifier le moteur Markdown
after_initialize do
  # Hook dans le système de markdown de Discourse pour modifier la configuration
  # du moteur markdown-it
  Discourse::Markdown.configure do |md|
    # Désactiver la règle 'code' qui gère les blocs de code par indentation
    # Cette règle convertit automatiquement le texte indenté avec 4 espaces ou une tabulation
    # en blocs de code (<pre><code>)
    
    # Récupérer la liste des règles actives du moteur markdown-it
    active_rules = md.block.ruler.getRules('')
    
    # Retirer la règle 'code' de la liste des règles actives
    # Cette règle est responsable de la détection des blocs de code par indentation
    md.block.ruler.disable(['code'])
    
    Rails.logger.info("Plugin discourse-no-indented-code: Règle 'code' désactivée avec succès")
  end
  
  # Alternative : Si la méthode ci-dessus ne fonctionne pas, utiliser cette approche
  # pour modifier directement la liste des règles autorisées
  begin
    # Vérifier si la méthode white_listed_markdown_it_rules existe
    if Discourse::Markdown.respond_to?(:white_listed_markdown_it_rules)
      # Retirer la règle 'code' de la liste blanche
      Discourse::Markdown.white_listed_markdown_it_rules.delete('code')
      Rails.logger.info("Plugin discourse-no-indented-code: Règle 'code' retirée de la liste blanche")
    end
  rescue => e
    Rails.logger.warn("Plugin discourse-no-indented-code: Méthode alternative échouée: #{e.message}")
  end
  
  # Hook supplémentaire pour s'assurer que la règle reste désactivée
  # même après un rechargement de la configuration
  DiscourseEvent.on(:markdown_context) do |context|
    if context[:markdown_it]
      context[:markdown_it].block.ruler.disable(['code'])
    end
  end
end
