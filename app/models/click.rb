# frozen_string_literal: true

class Click < ApplicationRecord
  belongs_to :url
  scope :group_by_day, -> (column, format) { group("strftime('%b %d',#{column})").order(column).count}
  scope :pluck_tally, -> (column) { pluck(column).tally.to_a }
  scope :current_month, -> { where('created_at >= ?', Date.today.beginning_of_month) }
end
