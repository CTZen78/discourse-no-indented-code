# name: discourse-no-indented-code
# about: Désactive la création de blocs de code par indentation (4 espaces/tabulation) en Markdown.
# version: 0.1
# authors: CAD Generation Team
# url: https://github.com/cadgeneration/discourse-no-indented-code

# Attendre que Discourse soit complètement initialisé avant de modifier le moteur Markdown
after_initialize do
  # Approche directe : Modifier le texte avant qu'il soit traité par Markdown
  # Cette méthode intercepte le contenu brut avant le rendu
  
  # Hook dans le processus de pré-traitement du texte
  on(:before_post_process_cooked) do |doc, post|
    # Post-traitement : Nettoyer le HTML généré pour retirer les blocs de code d'indentation
    if doc && doc.content
      # Rechercher et remplacer les blocs <pre><code> générés par l'indentation
      # Pattern: <pre><code>contenu sans langage spécifié</code></pre>
      doc.css('pre > code:not([class])').each do |code_block|
        # Vérifier si c'est probablement un bloc généré par indentation
        # (pas de classe de langage, contenu simple)
        parent_pre = code_block.parent
        if parent_pre && parent_pre.name == 'pre' && !code_block['class']
          # Récupérer le contenu du bloc
          content = code_block.inner_html
          
          # Remplacer le bloc <pre><code> par un simple texte indenté
          # en utilisant des espaces insécables pour préserver l'indentation
          indented_content = content.gsub(/^/, '    ').gsub(/\n/, "\n    ")
          replacement = "<div style='white-space: pre-wrap; margin-left: 2em;'>#{indented_content}</div>"
          
          parent_pre.replace(replacement)
        end
      end
    end
  end
  
  # Méthode alternative : Hook sur le texte brut avant traitement Markdown
  DiscourseEvent.on(:before_post_process_cooked) do |doc, post|
    Rails.logger.info("Plugin discourse-no-indented-code: Post-traitement appliqué au post #{post&.id}")
  end
  
  # Log de confirmation que le plugin est activé
  Rails.logger.info("Plugin discourse-no-indented-code: Plugin activé avec succès - Mode post-traitement")
end
