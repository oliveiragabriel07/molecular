module Molecular
  class Event < ActiveRecord::Base
    belongs_to :subscription

    scope :clicks, -> { where(label: 'click').group(:value) }
  end
end
