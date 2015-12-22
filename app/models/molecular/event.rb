module Molecular
  class Event < ActiveRecord::Base
    belongs_to :subscription

    after_destroy :update_counter_cache!, if: "label=='open' || label=='click'"
    after_save :update_counter_cache!, if: "label=='open' || label=='click'"
    delegate :update_counter_cache!, to: :subscription

    validates :subscription, presence: true

    scope :clicks_by_link, -> { where(label: 'click').group(:value) }
    scope :clicks, -> { where(label: 'click') }
    scope :opens, -> { where(label: 'open') }

    def self.create_queued
      create(label: 'queued')
    end
  end
end
