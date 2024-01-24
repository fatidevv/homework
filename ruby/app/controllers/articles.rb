class ArticleController
  def create_article(article)
    article_exists = Article.exists?(title: article['title'])
  
    return { ok: false, msg: 'Article with given title already exists' } if article_exists
  
    new_article = Article.new(title: article['title'], content: article['content'], created_at: Time.now)
  
    if new_article.save
      { ok: true, obj: new_article }
    else
      { ok: false, msg: 'Failed to save the article' }
    end
  rescue StandardError => e
    { ok: false, msg: "Error: #{e.message}" }
  end

  def update_article(id, new_data)
    article = Article.find_by(id: id)
  
    return { ok: false, msg: 'Article could not be found' } if article.nil?
  
    article.title = new_data['title']
    article.content = new_data['content']
  
    if article.save
      { ok: true, obj: article }
    else
      { ok: false, msg: 'Failed to save the article' }
    end
  rescue StandardError => e
    { ok: false, msg: "Error: #{e.message}" }
  end

  def get_article(id)
    article = Article.find_by(id: id)
  
    if article
      { ok: true, data: article }
    else
      { ok: false, msg: 'Article not found' }
    end
  rescue StandardError
    { ok: false, msg: "Error: #{e.message}" }
  end  

  def delete_article(_id)
    delete_count = Article.delete(_id)
  
    if delete_count > 0
      { ok: true, delete_count: delete_count }
    else
      { ok: false, msg: 'Article not found' }
    end
  rescue StandardError => e
    { ok: false, msg: "Error: #{e.message}" }
  end  

  def get_batch
    articles = Article.all
  
    { ok: true, data: articles }
  rescue StandardError
    { ok: false, msg: "Error: #{e.message}" }
  end
    
end
