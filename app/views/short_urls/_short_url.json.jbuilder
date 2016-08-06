json.extract! short_url, :id, :original_url, :short_url, :user_id, :visits_count, :created_at, :updated_at
json.url short_url_url(short_url, format: :json)