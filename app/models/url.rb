# frozen_string_literal: true

class Url < ApplicationRecord
  APP_URL = "http://localhost:3000/"
  # scope :latest, -> {}
  validates :original_url, presence: true
  validates :original_url, format: { with: URI.regexp }
  validates :short_url, uniqueness: true, presence: true
  before_create :generate_short_url
  has_many :clicks
  scope :find_by_short_url, -> (short_url) { where(short_url: short_url) }

  def generate_short_url 
    begin
      o =  [('A'..'Z')].map{|i| i.to_a}.flatten
      string = (0..4).map{ o[rand(o.length)] }.join
    end while Url.find_by_short_url(string).present?
    self.short_url = string
  end

  def full_url
    APP_URL + short_url
  end

  def update_clicks
    self.clicks_count = clicks_count.next
    self.save!
  end

end
