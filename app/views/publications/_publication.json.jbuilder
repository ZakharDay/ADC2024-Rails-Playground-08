json.extract! publication, :id, :title, :body, :embed, :created_at, :updated_at
json.url publication_url(publication, format: :json)
