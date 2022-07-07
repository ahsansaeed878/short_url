# frozen_string_literal: true

module ApplicationHelper
    def short_url(url)
        APP_URL + url.short_url
    end
end
