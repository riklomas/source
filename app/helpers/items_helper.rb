module ItemsHelper
  
  def format_categories(categories)
    links = categories.map do |cat|
      link_to cat.title, category_path(cat)
    end
    
    links.to_sentence.html_safe
  end
  
end
