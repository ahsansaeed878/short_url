# app/views/urls/index.json.jbuilder
json.data do
    json.array! @urls do |url|
      json.type "urls"
      json.id url.id
      json.attributes do 
        json.set! "created-at", url.created_at
        json.short_url url.short_url
        json.original_url url.original_url
        json.clicks_count url.clicks_count
      end
      json.relationships do
        json.clicks do
          json.data do
            json.array! url.clicks do |click|
              json.id click.id
              json.type "clicks"
            end
          end
        end
      end
    
      json.included do
        json.array! url.clicks do |click|
          json.type "type"
          json.id click.id
          json.attributes do
            json.browser click.browser
            json.platform click.platform
          end
        end
      end
  
    end
  end