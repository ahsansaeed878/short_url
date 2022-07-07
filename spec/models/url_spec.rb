# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it 'validates original URL is a valid URL' do
      url = FactoryBot.create(:url)
      expect(url.original_url).to match URI.regexp
    end

    it 'validates short URL is present' do
      url = FactoryBot.create(:url)
      expect(url.short_url).to be_present
    end

    # add more tests
  end
end