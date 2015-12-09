module Molecular
  class List < ActiveRecord::Base
    enum status: [:queued, :sent, :rejected, :spam, :unsub, :bounced,
                  :soft_bounced]

    belongs_to :campaign
    belongs_to :recipient
    has_many :events
  end
end
