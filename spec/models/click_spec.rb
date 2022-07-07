# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Click, type: :model do
  describe 'validations' do
    it 'validates url_id is valid' do
      url = FactoryBot.create(:url)
      click = url.clicks.new({url_id: url.id})
      expect(click).to be_valid
    end

    it 'validates browser is not null' do
      click = Click.new({browser: "Edge"})
      expect(click.browser).to be_present
    end

    it 'validates platform is not null' do
      click = Click.new({platform: "Windows"})
      expect(click.platform).to be_present
    end
  end
end
